"""Extract pinned old/new tethering binaries for measured patch porting; no ROM changes."""
import hashlib,json,shutil,subprocess,urllib.request,zipfile
from pathlib import Path
out=Path('tethering-evidence');out.mkdir(exist_ok=True)
pins=json.loads(Path('docs/A17-UPSTREAM.json').read_text())
receipt={}
def run(*args):
    r=subprocess.run(args,capture_output=True,text=True,check=True)
    return r.stdout+r.stderr
def dump(image,member,target):
    log=run('debugfs','-R',f'dump {member} {target}',str(image))
    assert target.is_file() and target.stat().st_size>0,(member,log)
    return log
for label,key in [('latest','gsi'),('prior','legacy_graphics')]:
    pin=pins[key];urllib.request.urlretrieve(pin['url'],'gsi.zip')
    assert hashlib.file_digest(open('gsi.zip','rb'),'sha256').hexdigest()==pin['sha256']
    with zipfile.ZipFile('gsi.zip') as z:
        names=[n for n in z.namelist() if Path(n).name=='system.img'];assert len(names)==1
        with z.open(names[0]) as src,open('system.img','wb') as dst:shutil.copyfileobj(src,dst)
    dump(Path('system.img'),'/system/apex/com.android.tethering.capex',Path('tethering.capex'))
    with zipfile.ZipFile('tethering.capex') as z:
        with z.open('original_apex') as src,open('tethering.apex','wb') as dst:shutil.copyfileobj(src,dst)
    with zipfile.ZipFile('tethering.apex') as z:
        with z.open('apex_payload.img') as src,open('payload.img','wb') as dst:shutil.copyfileobj(src,dst)
    receipt[label]={'pin':pin,'files':{}}
    for member in ['/bin/netbpfload','/lib64/libnetd_updatable.so','/lib64/libservice-connectivity.so']:
        target=out/(label+'-'+Path(member).name)
        log=dump(Path('payload.img'),member,target)
        assert target.read_bytes()[:4]==b'\x7fELF'
        receipt[label]['files'][member]={'sha256':hashlib.file_digest(target.open('rb'),'sha256').hexdigest(),'bytes':target.stat().st_size,'extraction':log}
        for suffix,args in [('symbols',['readelf','-Ws']),('sections',['readelf','-SW']),('assembly',['objdump','-d'])]:
            (out/(target.name+'.'+suffix+'.txt')).write_text(run(*args,str(target)))
    for f in ['gsi.zip','system.img','tethering.capex','tethering.apex','payload.img']:Path(f).unlink()
(out/'receipt.json').write_text(json.dumps(receipt,indent=2))
