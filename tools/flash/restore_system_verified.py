"""Restore exactly the verified partition prefix from the host rollback carrier.
Default checks only. Requires explicit --apply, recovery and preserved boot/vendor.
"""
from pathlib import Path
import gzip,hashlib,json,subprocess,argparse
import flash_system_verified as writer
from flash_system_verified import TARGET,SIZE,shell,partition_hash
if not __debug__:
 raise RuntimeError("Run without -O: verification assertions are required")

def restore_chunks(path,r):
 left=SIZE
 with gzip.open(path,'rb') as f:
  if r.get('overlay_prefix_file'):
   size=r['overlay_prefix_bytes']
   assert size==512*1024**2 and r['changed_window_indices']==[0,1]
   assert r['whole_partition_delta_verified'] is True
   prefix_hash=hashlib.sha256();remaining=size
   with (path.parent/r['overlay_prefix_file']).open('rb') as prefix:
    while remaining:
     block=prefix.read(min(remaining,2*1024**2));assert block
     assert len(f.read(len(block)))==len(block)
     remaining-=len(block);left-=len(block);prefix_hash.update(block)
     yield block
    assert not prefix.read(1)
   assert prefix_hash.hexdigest()==r['overlay_prefix_sha256']
  while left:
   b=f.read(min(left,2*1024**2));assert b
   left-=len(b)
   yield b
  tail=f.read();assert tail.decode()==r['trailing_text'] and len(tail)==r['trailing_bytes']

def verify(path,r):
 h=hashlib.sha256()
 for block in restore_chunks(path,r):h.update(block)
 assert h.hexdigest()==r['raw_sha256']

def main():
 a=argparse.ArgumentParser();a.add_argument('rollback_receipt');a.add_argument('output_receipt');a.add_argument('--apply',action='store_true');a.add_argument('--adb',default='adb');a.add_argument('--serial',required=True);a.add_argument('--boot-sha256',required=True);a.add_argument('--vendor-sha256',required=True);args=a.parse_args()
 writer.ADB,writer.SERIAL,writer.BOOT,writer.VENDOR=args.adb,args.serial,args.boot_sha256,args.vendor_sha256
 ADB,SERIAL,BOOT,VENDOR=writer.ADB,writer.SERIAL,writer.BOOT,writer.VENDOR
 r=json.loads(Path(args.rollback_receipt).read_text());p=Path(args.rollback_receipt).parent/r['compressed_file']
 assert r['device']==SERIAL and r['raw_bytes']==SIZE and r['gzip_readback_verified']
 verify(p,r)
 assert shell('getprop ro.serialno')==SERIAL or shell('getprop ro.boot.serialno')==SERIAL
 assert shell('id -u')=='0' and (shell('getprop ro.twrp.version') or shell('getprop ro.bootmode')=='recovery')
 assert shell('readlink -f '+TARGET)=='/dev/block/sda25' and shell('blockdev --getsize64 '+TARGET)==str(SIZE)
 assert not any('/dev/block/sda25' in l or l.split()[1].startswith('/system') for l in shell('cat /proc/mounts').splitlines())
 assert partition_hash('boot')==BOOT and partition_hash('vendor')==VENDOR
 out={'device':SERIAL,'target':TARGET,'apply':args.apply,'verified_raw_sha256':r['raw_sha256'],'restore_bytes':SIZE}
 Path(args.output_receipt).write_text(json.dumps(out,indent=2)+'\n')
 if not args.apply:print(json.dumps(out));return
 proc=subprocess.Popen([ADB,'-s',SERIAL,'shell','-T','dd of=/dev/block/by-name/system bs=1048576 && sync'],stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE)
 h=hashlib.sha256()
 for b in restore_chunks(p,r):
  h.update(b);proc.stdin.write(b)
 proc.stdin.close();stdout=proc.stdout.read();stderr=proc.stderr.read();code=proc.wait()
 out.update(write_returncode=code,stdout=stdout.decode(errors='replace'),stderr=stderr.decode(errors='replace'),stream_sha256=h.hexdigest())
 Path(args.output_receipt).write_text(json.dumps(out,indent=2)+'\n');assert code==0 and h.hexdigest()==r['raw_sha256']
 out['readback_sha256']=partition_hash('system');out['boot_sha256']=partition_hash('boot');out['vendor_sha256']=partition_hash('vendor')
 out['status']='readback-pass' if out['readback_sha256']==r['raw_sha256'] and out['boot_sha256']==BOOT and out['vendor_sha256']==VENDOR else 'readback-failure'
 Path(args.output_receipt).write_text(json.dumps(out,indent=2)+'\n');assert out['status']=='readback-pass'
 print(json.dumps(out))
if __name__=='__main__':main()
