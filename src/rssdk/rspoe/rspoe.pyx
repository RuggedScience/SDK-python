# distutils: language = c++

__all__ = ['RsPoe']

from enum import Enum, auto

from rssdk.rspoe cimport rspoe_c

class PoeState(Enum):
    StateDisabled = 0
    StateEnabled = auto()
    StateAuto = auto()
    StateError = auto()


cdef class RsPoe:
    cdef rspoe_c.RsPoe *_native
    def __cinit__(self):
        self._native = rspoe_c.createRsPoe()
    def __dealloc__(self):
        self._native.destroy()
    def setXmlFile(self, filename: str) -> bool:
        return self._native.setXmlFile(filename.encode('utf-8'))
    def getPortState(self, port: int) -> PoeState:
        return PoeState(<int>self._native.getPortState(port))
    def setPortState(self, port: int, state: PoeState) -> int:
        return self._native.setPortState(port, state.value)
    def getLastError(self) -> str:
        return self._native.getLastErrorString().decode('UTF-8')
    def version(self) -> str:
        return rspoe_c.rsPoeVersion().decode('UTF-8')