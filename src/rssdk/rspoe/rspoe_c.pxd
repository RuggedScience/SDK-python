# distutils: language = c++

from libcpp.string cimport string


cdef extern from "rspoe.h" namespace "rs":
    cdef enum class PoeState:
        pass
        
    cdef cppclass RsPoe:
        void destroy()
        void setXmlFile(const char *)
        PoeState getPortState(int)
        void setPortState(int, PoeState)

        string getLastErrorString()

    RsPoe* createRsPoe() except +
    const char* rsPoeVersion()

