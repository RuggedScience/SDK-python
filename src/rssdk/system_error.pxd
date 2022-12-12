from libcpp cimport bool
#from libc cimport errno

cdef extern from "<system_error>" namespace "std":
    cdef enum class errc:
        pass

    cdef cppclass error_category:
        str name()

    cdef cppclass error_code:
        bool operator bool()
        bool operator==(const error_code& lhs, const error_code& rhs)
        int value()
        str message()
        const error_category& category()

    error_code make_error_code(errc)
