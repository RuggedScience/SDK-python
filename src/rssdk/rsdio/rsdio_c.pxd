from libcpp cimport bool
from libcpp.string cimport string
from libcpp.map cimport map


cdef extern from "rsdio.h" namespace "rs":
    cpdef enum class OutputMode:
            pass

    cdef cppclass RsDio:
        void destroy()
        void setXmlFile(const char *, bool)
        void setOutputMode(int, OutputMode)
        bool digitalRead(int, int)
        void digitalWrite(int, int, bool)
        map[int, bool] readAll(int)

        string getLastErrorString()

    RsDio* createRsDio() except +
    const char* rsDioVersion()