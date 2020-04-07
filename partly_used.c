#include "partly_used.h"

/* The following variable definition will not be removed, when
 * compiled with --multifile, even though unused3() is never called.
 */
static int not_removed[256] = {42};

int*
fn_unused5(void)
{
	return not_removed;
}

/* This function is called from main */
int
fn_used(void)
{
	return 42;
}
