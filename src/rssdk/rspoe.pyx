from libcpp.string cimport string
from rssdk.system_error cimport error_code

cdef extern from "rspoe.h" namespace "rs":
    cpdef enum class PoeState:
        Disabled = 0
        Enabled = 1
        Auto = 2
        Error = 3
        
    cdef cppclass RsPoe:
        void destroy()
        void setXmlFile(const char *)
        PoeState getPortState(int)
        void setPortState(int, PoeState)

        error_code getLastError()
        string getLastErrorString()

    RsPoe* createRsPoe() except +
    const char* rsPoeVersion()


cdef class PyRsPoe:
    cdef RsPoe *_native
    def __cinit__(self):
        self._native = createRsPoe()
    def __dealloc__(self):
        self._native.destroy()
    def setXmlFile(self, filename: str) -> bool:
        self._native.setXmlFile(filename.encode('utf-8'))
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
    def getPortState(self, port: int) -> PoeState:
        state = self._native.getPortState(port)
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
    def setPortState(self, port: int, state: PoeState) -> int:
        self._native.setPortState(port, state)
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
    def getLastError(self) -> str:
        return self._native.getLastErrorString().decode('UTF-8')
    def version(self) -> str:
        return rsPoeVersion().decode('UTF-8')