#include "/amd64/include/u.h"
#define P2W(ptr) (assert(ptr < (1ULL<<32)), (ulong)ptr)
#define P2WIF(ptr) (((uintptr _ptr = ptr) > (1ULL<<32)) ? sysfatal("%p < (1ULL<<32)", _ptr) : (ulong)_ptr)
