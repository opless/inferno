/* TODO: This is totally unexpected to work - SCW */

#include "lib9.h"
#include <a.out.h>
#include <dynld.h>

#define	CHK(i,ntab)	if((unsigned)(i)>=(ntab))return "bad relocation index"

long
dynmagic(void)
{
	return DYN_MAGIC | I_MAGIC;
}

char*
dynreloc(uchar *b, ulong p, int m, Dynsym **tab, int ntab)
{
	int i;
	ulong v, *pp;

	p += (ulong)b;
	pp = (ulong*)p;
	v = *pp;
	switch(m){
	case 0:
		v += (ulong)b;
		break;
	case 1:
		i = v>>22;
		v &= 0x3fffff;
		CHK(i, ntab);
		v += tab[i]->addr;
		break;
	case 2:
		i = v>>22;
		CHK(i, ntab);
		v = tab[i]->addr -p-4;
		break;
	default:
		return "bad relocation mode";
	}
	*pp = v;
	return nil;
}
