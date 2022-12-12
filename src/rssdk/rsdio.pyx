from libcpp cimport bool
from libcpp.string cimport string
from libcpp.map cimport map

from rssdk.system_error cimport error_code
from rssdk.rserrors cimport code_to_exception

cdef extern from "rsdio.h" namespace "rs":
    cpdef enum class OutputMode:
        Error = 0
        Source = -1
        Sink = -2

    cdef cppclass RsDio:
        void destroy()
        void setXmlFile(const char *, bool)
        void setOutputMode(int, OutputMode)
        bool digitalRead(int, int)
        void digitalWrite(int, int, bool)
        map[int, bool] readAll(int)

        error_code getLastError()
        string getLastErrorString()

    RsDio* createRsDio() except +
    const char* rsDioVersion()



cdef code_to_exception(error_code code, str message):
    if code:
        if code == make_error_code(<errc>errno.EPERM):
            raise PermissionError(message)
        if code == make_error_code(<errc>errno.ENOENT):
            raise FileNotFoundError(message)
        if code == make_error_code(<errc>errno.ENOSYS):
            raise NotImplementedError(message)
        if code == make_error_code(<errc>errno.EINVAL):
            raise ValueError(message)
        raise Exception(message)


from typing import Dict

cdef class PyRsDio:
    cdef RsDio *_native
    def __cinit__(self):
        self._native = createRsDio()
    def __dealloc__(self):
        self._native.destroy()
    def setXmlFile(self, filename: str, debug=False) -> None:
        self._native.setXmlFile(filename.encode('utf-8'), debug)
        code_to_exception(self._native.getLastError(), "Test")
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
    def setOutputMode(self, dio: int, mode: OutputMode) -> None:
        self._native.setOutputMode(dio, mode)
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
    def digitalRead(self, dio: int, pin: int) -> bool:
        state = self._native.digitalRead(dio, pin) 
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
        return state
    def digitalWrite(self, dio: int, pin: int, state: bool) -> None:
        self._native.digitalWrite(dio, pin, state)
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
    def readAll(self, dio: int) -> Dict[int, bool]:
        states = self._native.readAll(dio)
        if self._native.getLastError():
            raise Exception(self._native.getLastErrorString())
        return states
    def getLastError(self) -> str:
        return self._native.getLastErrorString().decode('utf-8')
    def version(self) -> str:
        return rsDioVersion().decode('utf-8')