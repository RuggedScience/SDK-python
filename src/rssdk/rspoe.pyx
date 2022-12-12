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
        return self._native.setXmlFile(filename.encode('utf-8'))
    def getPortState(self, port: int) -> PoeState:
        return self._native.getPortState(port)
    def setPortState(self, port: int, state: PoeState) -> int:
        return self._native.setPortState(port, state)
    def getLastError(self) -> str:
        return self._native.getLastErrorString().decode('UTF-8')
    def version(self) -> str:
        return rsPoeVersion().decode('UTF-8')