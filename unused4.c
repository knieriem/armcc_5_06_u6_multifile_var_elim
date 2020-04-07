/* All definitions within this file get removed by the linker as expected,
 * regardless of whether files are compiled using --multifile or not.
 */

static const int a[2000] = {42};

const int d[4000] = {'d'};
int e[400] = {'e'};

int
fn_unused4(int v)
{
	return v*a[0] + d[0];
}
