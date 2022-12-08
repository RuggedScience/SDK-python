# distutils: language = c++

__all__ = ['RsDio']

from enum import Enum
from typing import Dict


from rssdk.rsdio cimport rsdio_c

class OutputMode(Enum):
    ModeError = 0
    ModePnp = -1
    ModeNpn = -2


cdef class RsDio:
    cdef rsdio_c.RsDio *_native
    def __cinit__(self):
        self._native = rsdio_c.createRsDio()
    def __dealloc__(self):
        self._native.destroy()
    def setXmlFile(self, filename: str, debug=False) -> bool:
        self._native.setXmlFile(filename.encode('utf-8'), debug)
    def setOutputMode(self, dio: int, mode: OutputMode):
        self._native.setOutputMode(dio, mode.value)
    def digitalRead(self, dio: int, pin: int) -> int:
        return self._native.digitalRead(dio, pin)
    def digitalWrite(self, dio: int, pin: int, state: bool) -> int:
        self._native.digitalWrite(dio, pin, state)
    def readAll(self, dio: int) -> Dict[int, bool]:
        return self._native.readAll(dio)
    def getLastError(self) -> str:
        return self._native.getLastErrorString().decode('UTF-8')
    def version(self) -> str:
        return rsdio_c.rsDioVersion().decode('UTF-8')