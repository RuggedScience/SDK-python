from libcpp cimport bool
from libcpp.string cimport string


cdef extern from "rspoe.h":
    cdef enum PoeState:
        pass

    cdef cppclass RsPoe:
        void destroy()
        bool setXmlFile(const char *)
        PoeState getPortState(int)
        int setPortState(int, PoeState)
        string getLastError()
        string version()

    RsPoe* createRsPoe() except +

