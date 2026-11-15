"""Record remote runner headroom and reject inadequate build workspace."""
import json,shutil,sys
from pathlib import Path
required=int(sys.argv[1])*1024**3;usage=shutil.disk_usage('.')
archives=sum(p.stat().st_size for p in Path('download-cache').rglob('*') if p.is_file()) if Path('download-cache').exists() else 0
record={'free_bytes':usage.free,'required_free_bytes':required,'compressed_archive_bytes_retained':archives,'status':'pass' if usage.free>=required else 'failure','limit':'Pre-stage headroom check, not a measurement or guarantee of peak build use.'}
Path(sys.argv[2]).write_text(json.dumps(record,indent=2)+'\n');print(json.dumps(record))
if usage.free<required:raise SystemExit('Insufficient runner space for guarded image/APEX generation')
