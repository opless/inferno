#include "lib9.h"

ulong
getcallerspc(uintptr pc)
{
	if(pc > (1ULL<<32))
		sysfatal("%p < (1ULL<<32)", pc);
	return (ulong)pc;
}

ulong
ptrcheck(uintptr p)
{
	if(p > (1ULL<<32))
		sysfatal("0x%p < (1ULL<<32)", p);
	return (ulong)p;
}
