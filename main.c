#include "partly_used.h"

int __initial_sp;

/* If the 'const' in the following definition of 'cur' is present,
 * definitions in unused.c will not be removed by the linker in --multifile mode.
 *
 * In contrast, if the 'const' is commented out,
 * the linker will remove unused.c's definitions.
 *
 * In normal mode (1 source file -> 1 object file), unused definitions
 * in the other files will always be removed by the linker.
 */
static const int cur = 42;

static const int*
get(const int *p)
{
	return p;
}

const int *dest;
int
main(void)
{
	dest = get(&cur);
	return fn_used();
}
