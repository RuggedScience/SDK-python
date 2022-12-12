from rssdk.system_error cimport error_code, errc, make_error_code


cdef extern from "rserrors.h":
    cpdef enum class RsErrorCode:
        NotInitialized = 1
        XmlParseError = 2
        UnknownError = 3

    error_code make_error_code(RsErrorCode)
        