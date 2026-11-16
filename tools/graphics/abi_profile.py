"""Read original ELF relocation-backed vtable slots; no target execution."""
import struct,json,hashlib
from pathlib import Path
class ELF:
 def __init__(self,path):
  self.path=Path(path);self.d=self.path.read_bytes();assert self.d[:4]==b'\x7fELF' and self.d[5]==1
  self.bits=64 if self.d[4]==2 else 32;self.ptr=self.bits//8
  if self.bits==64:off=struct.unpack_from('<Q',self.d,40)[0];size,num,strings=struct.unpack_from('<HHH',self.d,58);fmt='<IIQQQQIIQQ'
  else:off=struct.unpack_from('<I',self.d,32)[0];size,num,strings=struct.unpack_from('<HHH',self.d,46);fmt='<IIIIIIIIII'
  self.sections=[struct.unpack_from(fmt,self.d,off+i*size) for i in range(num)]
  def raw(s):return self.d[s[4]:s[4]+s[5]]
  names=raw(self.sections[strings]);self.named={names[s[0]:].split(b'\0',1)[0].decode():s for s in self.sections}
  self.symbols=[];sec=self.named['.dynsym'];strings=raw(self.sections[sec[6]])
  for i in range(0,sec[5],sec[9]):
   if self.bits==64:n,info,other,idx,value,size=struct.unpack_from('<IBBHQQ',self.d,sec[4]+i)
   else:n,value,size,info,other,idx=struct.unpack_from('<IIIBBH',self.d,sec[4]+i)
   name=strings[n:].split(b'\0',1)[0].decode();self.symbols.append({'name':name,'value':value,'size':size,'defined':idx!=0,'type':info&15})
  self.relocations={}
  for section in self.sections:
   typ=section[1];data=raw(section)
   if typ in (4,9):
    step=(24 if typ==4 else 16) if self.bits==64 else (12 if typ==4 else 8)
    for i in range(0,len(data),step):
     offset,info=struct.unpack_from('<QQ' if self.bits==64 else '<II',data,i);addend=struct.unpack_from('<q' if self.bits==64 else '<i',data,i+2*self.ptr)[0] if typ==4 else self.word(offset)
     self.relocations[offset]=(info,addend)
   elif typ in (0x60000001,0x60000002):
    assert data[:4]==b'APS2';pos=4
    def leb():
     nonlocal pos
     result=0;shift=0
     while True:
      b=data[pos];pos+=1;result|=(b&127)<<shift;shift+=7
      if not b&128:break
     return result-(1<<shift) if b&64 else result
    count=leb();offset=leb();addend=0;done=0
    while done<count:
     group=leb();flags=leb();delta=leb() if flags&2 else None;info=leb() if flags&1 else None
     adddelta=leb() if flags&4 and flags&8 else None
     for _ in range(group):
      offset+=delta if flags&2 else leb();inf=info if flags&1 else leb()
      if flags&8:addend+=adddelta if flags&4 else leb()
      else:addend=0
      actual_addend=addend if typ==0x60000002 else self.word(offset)
      self.relocations[offset]=(inf,actual_addend);done+=1
    assert done==count and pos==len(data)
 def word(self,address):
  for s in self.sections:
   if s[3]<=address and address+self.ptr<=s[3]+s[5] and s[1]!=8:return int.from_bytes(self.d[s[4]+address-s[3]:s[4]+address-s[3]+self.ptr],'little')
  raise ValueError('Unmapped ELF word')
 def slot(self,address):
  if address in self.relocations:
   info,addend=self.relocations[address];symidx=info>>32 if self.bits==64 else info>>8;typ=info&0xffffffff if self.bits==64 else info&255
   if symidx:
    sym=self.symbols[symidx];return {'symbol':sym['name'],'addend':addend,'relocation_type':typ}
   value=addend
  else:value=self.word(address)
  if value==0:return {'value':0}
  found=[s['name'] for s in self.symbols if s['defined'] and s['value']==value]
  return {'symbols':found,'local_address':hex(value)}
 def profile(self):
  tables={}
  for sym in self.symbols:
   if sym['defined'] and sym['name'].startswith('_ZTV'):
    tables[sym['name']]={'size':sym['size'],'slots':[self.slot(sym['value']+i) for i in range(0,sym['size'],self.ptr)]}
  return {'file':self.path.name,'sha256':hashlib.sha256(self.d).hexdigest(),'bits':self.bits,'tables':tables,'limitations':'Original dynamic relocations decoded; unnamed local slot targets require separate disassembly. No runtime observation.'}
if __name__=='__main__':
 import sys
 print(json.dumps(ELF(sys.argv[1]).profile(),indent=2))
