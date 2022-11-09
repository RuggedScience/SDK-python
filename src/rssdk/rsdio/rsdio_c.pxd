from libcpp cimport bool
from libcpp.string cimport string


cdef extern from "rsdio.h":
    cdef enum OutputMode:
        pass

    cdef cppclass RsDio:
        void destroy()
        bool setXmlFile(const char *, bool)
        int setOutputMode(int, OutputMode)
        int digitalRead(int, int)
        int digitalWrite(int, int, bool)
        string getLastError()
        string version()

    RsDio* createRsDio() except +