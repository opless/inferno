#include "/amd64/include/u.h"
#define P2W(ptr) ((assert(ptr < (1ULL<<32))), (WORD)ptr)
#define P2WIF(ptr) if(ptr < (1ULL<<32)){ (WORD)ptr}else{_assert("ptr < (1ULL<<32)")}
