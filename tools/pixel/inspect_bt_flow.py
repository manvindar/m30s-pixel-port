"""Inspect exact Bluetooth conditional/error/normal blocks after unique site matching."""
import hashlib,json,shutil,struct,subprocess,sys,tempfile,zipfile
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'graphics'))
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'downloads'))
from common import dump,unpack_apex,digest
from abi_profile import ELF
from verified_input import obtain
out=Path('bt-graphics-evidence');out.mkdir(exist_ok=True)
pins=json.loads(Path('docs/A17-UPSTREAM.json').read_text());records={}
def signed(x,bits):return x-(1<<bits) if x&(1<<(bits-1)) else x
def target(w,a):return a+signed((w>>5)&0x3fff,14)*4
for label,key,cache,sites,exits in [('latest','gsi','gsi',[0xc550b8,0xc55478,0xaeb484],[0xc550e4,0xc55530]),('prior','legacy_graphics','graphics',[0xc49bbc,0xc49f7c,0xae047c],[0xc49be8,0xc4a034])]:
 pin=pins[key];archive=obtain(pin['url'],pin['sha256'],Path('download-cache')/cache/'gsi.zip')
 with tempfile.TemporaryDirectory(prefix='bt-flow-') as work:
  w=Path(work);image=w/'system.img'
  with zipfile.ZipFile(archive) as z:
   members=[n for n in z.namelist() if Path(n).name=='system.img'];assert len(members)==1
   with z.open(members[0]) as src,image.open('wb') as dst:shutil.copyfileobj(src,dst)
  package=dump(image,'/system/apex/com.android.bt.capex',w/'bt.capex');_,payload,_=unpack_apex(package,w/'bt')
  lib=dump(payload,'/lib64/libbluetooth_jni.so',w/'bt.so');data=lib.read_bytes();elf=ELF(lib)
  sha=digest(lib);expected='0d11d654500ecc7a749af5568204e6217868b82fe816a145a32e05b40404bec0' if label=='latest' else 'e0ae3969c6dc2d606d384ebf5beed735e2ddd5f0ff6d1da674329fff1bee64e8';assert sha==expected
  records[label]={'sha256':sha,'bytes':len(data),'sites':[],'blocks':[]}
  points=list(exits)
  for a in sites:
   word=struct.unpack_from('<I',data,a)[0];assert word&0xfff80000==0x36000000
   t=target(word,a);records[label]['sites'].append({'offset':a,'word':word,'target':t});points.extend([a,t])
  for a in sorted(set(points)):
   start=a-128;end=a+384;raw=data[start:end];file=out/(label+'-'+hex(a)+'.bin');file.write_bytes(raw)
   asm=subprocess.check_output(['aarch64-linux-gnu-objdump','-D','-b','binary','-m','aarch64','--adjust-vma='+str(start),str(file)],text=True)
   (out/(label+'-'+hex(a)+'.asm')).write_text(asm)
   strings=[];regs={}
   def raw_at(addr):
    for sec in elf.sections:
     if sec[3]<=addr<sec[3]+sec[5] and sec[1]!=8:return data[sec[4]+addr-sec[3]:sec[4]+addr-sec[3]+160]
    return b''
   for off in range(start,end,4):
    word=struct.unpack_from('<I',data,off)[0];rd=word&31
    if word&0x9f000000==0x90000000:
     imm=((word>>5)&0x7ffff)<<2|((word>>29)&3);regs[rd]=(off&~4095)+(signed(imm,21)<<12)
    elif word&0xff000000==0x91000000:
     rn=(word>>5)&31
     if rn in regs:
      regs[rd]=regs[rn]+(((word>>10)&4095)<<(12 if word&(1<<22) else 0));blob=raw_at(regs[rd]);text=blob.split(b'\0',1)[0]
      if text and all(32<=c<127 or c in (9,10) for c in text):strings.append({'instruction':off,'address':regs[rd],'text':text.decode()})
   records[label]['blocks'].append({'center':a,'start':start,'end':end,'sha256':hashlib.sha256(raw).hexdigest(),'addressed_strings':strings})
(out/'control-flow-receipt.json').write_text(json.dumps(records,indent=2))
