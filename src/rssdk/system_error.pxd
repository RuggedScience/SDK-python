from libcpp cimport bool

cdef extern from "<system_error>" namespace "std":
    cdef enum class errc:
        no_such_file_or_directory = 2
        operation_not_permitted = 1
        protocol_error = 71

    cdef cppclass error_category:
        str name()

    cdef cppclass error_code:
        bool operator bool()
        bool operator==(const error_code& lhs, const error_code& rhs)
        int value()
        str message()
        const error_category& category()

    error_code make_error_code(errc)
