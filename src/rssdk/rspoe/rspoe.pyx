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
        return PoeState(self._native.getPortState(port))
    def setPortState(self, port: int, state: PoeState) -> int:
        return self._native.setPortState(port, state.value)
    def getLastError(self) -> str:
        return self._native.getLastError().decode('UTF-8')
    def version(self) -> str:
        return self._native.version().decode('UTF-8')