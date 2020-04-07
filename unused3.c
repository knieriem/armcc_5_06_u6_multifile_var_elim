static const int a[2000] = {42};

const int b[4000] = {'b'};
int c[400] = {'c'};			/* <- not removed if compiled with --multifile */

int
fn_unused3(int v)
{
	return v*a[0] + b[0] + c[0];
}
