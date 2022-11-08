__all__ = ['RsDio', 'OutputMode', 'RsPoe', 'PoeState']

import os
import sys

# On Windows we will install the driver DLL with this module.
# Make sure we tell Windows to look here.
if os.name == 'nt':
    dir_path = os.path.dirname(os.path.realpath(__file__))
    if sys.version_info[1] < 8:
        os.environ['PATH'] = dir_path + os.pathsep + os.environ['PATH']
    else:
        os.add_dll_directory(dir_path)

from .rsdio import RsDio, OutputMode
from .rspoe import RsPoe, PoeState