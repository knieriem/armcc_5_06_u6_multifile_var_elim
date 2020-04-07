/* The following variable definition will not be removed, when compiled
 * in --multifile mode, even though all definitions in this file are unused.
 */
static int not_removed[256] = {42};

int*
fn_unused(void)
{
	return not_removed;
}
