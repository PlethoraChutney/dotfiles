# open volumes entirely separately, not as subvolumes

from chimerax.core.commands import run, register, CmdDesc, StringArg
from glob import glob
import sys

def open_separately(session, vol_glob):
    files_to_open = glob(vol_glob)
    files_to_open = sorted(list(files_to_open))
    for f in files_to_open:
        run(session, f"open {f}")

desc = CmdDesc(
    required = [("vol_glob", StringArg)],
    synopsis = "Open volumes as separate objects, not as sub-models."
)
register("opensep", desc, open_separately, logger = session.logger)
