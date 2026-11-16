"""Host-only system writer. Default verifies gates; --apply enables system write.
No reboot, mount, userdata, SD, boot or vendor write commands are present.
"""
from pathlib import Path
import argparse,subprocess,json,hashlib,os,time
if not __debug__:
 raise RuntimeError("Run without -O: verification assertions are required")
ADB='adb'
SERIAL=None;TARGET='/dev/block/by-name/system';SIZE=5033164800
BOOT=None
VENDOR=None
def shell(command):
 return subprocess.run([ADB,'-s',SERIAL,'shell',command],check=True,capture_output=True,text=True).stdout.strip()
def partition_hash(name):
 return shell('sha256sum /dev/block/by-name/'+name).split()[0]
def hash_image(path,manifest):
 h=hashlib.sha256();actual=[]
 with path.open('rb') as f:
  before=os.fstat(f.fileno())
  for w in manifest['windows']:
   assert f.tell()==w['offset_bytes']
   left=w['length_bytes'];v=hashlib.sha256()
   while left:
    data=f.read(min(left,2*1024**2));assert data
    left-=len(data);h.update(data);v.update(data)
   assert v.hexdigest()==w['sha256']
   actual.append(v.hexdigest())
  assert f.tell()==SIZE and not f.read(1)
  after=os.fstat(f.fileno())
  assert (before.st_size,before.st_mtime_ns)==(after.st_size,after.st_mtime_ns)
 assert h.hexdigest()==manifest['sha256']
 return before

def main():
 global ADB,SERIAL,BOOT,VENDOR
 p=argparse.ArgumentParser();p.add_argument('image');p.add_argument('manifest');p.add_argument('rollback_receipt');p.add_argument('receipt');p.add_argument('--apply',action='store_true');p.add_argument('--resume-interrupted-write');p.add_argument('--adb',default='adb');p.add_argument('--serial',required=True);p.add_argument('--boot-sha256',required=True);p.add_argument('--vendor-sha256',required=True);p.add_argument('--source-commit',required=True);p.add_argument('--actions-run',required=True);a=p.parse_args()
 ADB,SERIAL,BOOT,VENDOR=a.adb,a.serial,a.boot_sha256,a.vendor_sha256
 image=Path(a.image);m=json.loads(Path(a.manifest).read_text());r=json.loads(Path(a.rollback_receipt).read_text())
 assert m['schema']=='m30s-raw-readback-v1' and m['partition']=='system' and m['size_bytes']==SIZE
 assert len(m['windows'])==19
 assert m['source_commit']==a.source_commit
 assert m['actions_run']==a.actions_run
 assert r['device']==SERIAL and r['raw_bytes']==SIZE and r['gzip_readback_verified'] is True
 backup=Path(a.rollback_receipt).parent/r['compressed_file'];assert backup.is_file() and backup.stat().st_size==r['compressed_bytes']
 backup_hash=hashlib.sha256()
 with backup.open('rb') as backup_stream:
  while block:=backup_stream.read(2*1024**2):backup_hash.update(block)
 assert backup_hash.hexdigest()==r['compressed_sha256'],'Rollback carrier changed'
 if r.get('overlay_prefix_file'):
  prefix_path=backup.parent/r['overlay_prefix_file']
  assert prefix_path.stat().st_size==r['overlay_prefix_bytes']==512*1024**2 and r['changed_window_indices']==[0,1]
  prefix_hash=hashlib.sha256()
  with prefix_path.open('rb') as prefix:
   while block:=prefix.read(2*1024**2):prefix_hash.update(block)
  assert prefix_hash.hexdigest()==r['overlay_prefix_sha256']
  assert r['whole_partition_delta_verified'] is True
 state=hash_image(image,m)
 assert shell('getprop ro.serialno')==SERIAL or shell('getprop ro.boot.serialno')==SERIAL
 assert shell('id -u')=='0'
 recovery=shell('getprop ro.twrp.version');mode=shell('getprop ro.bootmode')
 assert recovery or mode=='recovery','Must be in verified recovery'
 assert shell('readlink -f '+TARGET)=='/dev/block/sda25'
 assert shell('blockdev --getsize64 '+TARGET)==str(SIZE)
 mounts=shell('cat /proc/mounts')
 assert not any('/dev/block/sda25' in l or l.split()[1].startswith('/system') for l in mounts.splitlines()),'System must be unmounted'
 assert partition_hash('boot')==BOOT and partition_hash('vendor')==VENDOR
 current_system=partition_hash('system')
 if a.resume_interrupted_write:
  prior=json.loads(Path(a.resume_interrupted_write).read_text())
  assert a.apply and Path(a.resume_interrupted_write).resolve()!=Path(a.receipt).resolve()
  assert prior['device']==SERIAL and prior['target']==TARGET and prior['apply'] is True
  assert prior['candidate_sha256']==m['sha256'] and prior['source_commit']==m['source_commit']
  assert prior['actions_run']==m['actions_run'] and prior['gates']=='pass' and prior['write_returncode']==255
  # A transport interruption leaves a partial system. Revalidate the exact
  # original rollback stream rather than asserting it equals partial bytes.
  from restore_system_verified import verify
  verify(backup,r)
 else:
  assert current_system==r['raw_sha256'],'Rollback must match current system'
 receipt={'device':SERIAL,'target':TARGET,'candidate_sha256':m['sha256'],'source_commit':m['source_commit'],'actions_run':m['actions_run'],'apply':a.apply,'gates':'pass','device_validation':False,'prewrite_system_sha256':current_system,'resumes_interrupted_receipt':a.resume_interrupted_write}
 Path(a.receipt).write_text(json.dumps(receipt,indent=2)+'\n')
 if not a.apply:
  print(json.dumps(receipt));return
 # Independent local image checks precede all device writes. The only target
 # is the fixed system partition, whose mount/size/rollback state is verified.
 assert (image.stat().st_size,image.stat().st_mtime_ns)==(state.st_size,state.st_mtime_ns)
 started=time.time()
 with image.open('rb') as f:
  result=subprocess.run([ADB,'-s',SERIAL,'shell','-T','dd of=/dev/block/by-name/system bs=1048576 && sync'],stdin=f,capture_output=True)
 receipt.update(write_returncode=result.returncode,write_stdout=result.stdout.decode(errors='replace'),write_stderr=result.stderr.decode(errors='replace'))
 Path(a.receipt).write_text(json.dumps(receipt,indent=2)+'\n');assert result.returncode==0
 actual=partition_hash('system');receipt['readback_sha256']=actual
 receipt['retained_boot_sha256']=partition_hash('boot');receipt['retained_vendor_sha256']=partition_hash('vendor');receipt['seconds']=time.time()-started
 receipt['status']='readback-pass' if actual==m['sha256'] and receipt['retained_boot_sha256']==BOOT and receipt['retained_vendor_sha256']==VENDOR else 'readback-failure'
 Path(a.receipt).write_text(json.dumps(receipt,indent=2)+'\n');assert receipt['status']=='readback-pass','Stay in recovery for verified rollback; do not reboot failed readback'
 print(json.dumps(receipt))
if __name__=='__main__':main()
