"""Bounded remote Bluetooth patch windows and graphics ABI binaries; no ROM changes."""
import hashlib,json,shutil,struct,subprocess,sys,tempfile,zipfile
from pathlib import Path
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'graphics'))
sys.path.insert(0,str(Path(__file__).resolve().parents[1]/'downloads'))
from common import dump,digest,unpack_apex
from abi_profile import ELF
from verified_input import obtain
out=Path('bt-graphics-evidence');out.mkdir(exist_ok=True)
pins=json.loads(Path('docs/A17-UPSTREAM.json').read_text());receipt={};bt={}
def norm(w):
 if w&0x7c000000==0x14000000:return w&0xfc000000
 if w&0x9f000000 in (0x90000000,0x10000000):return w&0x9f00001f
 if w&0x3b000000==0x18000000:return w&0xff00001f
 if w&0xff000010==0x54000000:return w&0xff00001f
 if w&0x7e000000==0x34000000:return w&0xff00001f
 if w&0x7e000000==0x36000000:return w&0xfff8001f
 if w&0xff000000==0x91000000:return w&0xffc003ff
 return w
for label,key,cache in [('latest','gsi','gsi'),('prior','legacy_graphics','graphics')]:
 pin=pins[key];archive=obtain(pin['url'],pin['sha256'],Path('download-cache')/cache/'gsi.zip')
 with tempfile.TemporaryDirectory(prefix='bt-graphics-') as work:
  w=Path(work);image=w/'system.img'
  with zipfile.ZipFile(archive) as z:
   names=[n for n in z.namelist() if Path(n).name=='system.img'];assert len(names)==1
   with z.open(names[0]) as src,image.open('wb') as dst:shutil.copyfileobj(src,dst)
  receipt[label]={'pin':pin,'files':{}}
  for context,apex in [('codec','com.android.media.swcodec.capex'),('bluetooth','com.android.bt.capex')]:
   package=dump(image,'/system/apex/'+apex,w/apex);_,payload,_=unpack_apex(package,w/context)
   if context=='bluetooth':
    target=dump(payload,'/lib64/libbluetooth_jni.so',w/'bluetooth.so');bt[label]=target.read_bytes();receipt[label]['bluetooth_sha256']=digest(target)
   else:
    for abi,directory in [('arm64','lib64'),('arm32','lib')]:
     for name,src,base in [('system',image,'/system'),('codec',payload,'')]:
      target=dump(src,base+'/'+directory+'/libui.so',out/(label+'-'+name+'-'+abi+'-libui.so'));receipt[label]['files'][target.name]={'sha256':digest(target),'bytes':target.stat().st_size}
      (out/(target.name+'.abi.json')).write_text(json.dumps(ELF(target).profile(),indent=2))
old,new=bt['prior'],bt['latest']
assert hashlib.sha256(old).hexdigest().startswith('e0ae3969c6dc2d60')
assert hashlib.sha256(new).hexdigest().startswith('0d11d654500ecc7a')
words=[norm(x[0]) for x in struct.iter_unpack('<I',new[:len(new)//4*4])]
sites=[0xc49bbc,0xc4adb4,0xc49be8,0xc49f7c,0xc4adec,0xc4a034,0xae047c,0xae0558]
matched=[]
for site in sites:
 candidates=[];radius=12
 expected=[norm(struct.unpack_from('<I',old,x)[0]) for x in range(site-radius*4,site+(radius+1)*4,4)]
 center=expected[radius]
 for ix,x in enumerate(words):
  if x==center and ix>=radius and words[ix-radius:ix+radius+1]==expected:candidates.append(ix*4)
 matched.append({'prior_offset':site,'radius_instructions':radius,'candidates':candidates,'prior_window_hex':old[site-64:site+68].hex(),'latest_windows':[{'offset':x,'window_hex':new[x-64:x+68].hex()} for x in candidates]})
receipt['bluetooth_windows']={'status':'measured-not-accepted','matched':matched,'limitation':'Masked match is a location candidate only; exact branches, surrounding control flow and normal exit must be reviewed before patch.'}
(out/'receipt.json').write_text(json.dumps(receipt,indent=2))
print([(hex(m['prior_offset']),[hex(x) for x in m['candidates']]) for m in matched])
