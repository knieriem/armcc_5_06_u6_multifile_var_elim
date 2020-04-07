
static void
foo(char *dst, int n)
{
	int i;

	/* this is just some code
	 * so that one can see a difference
	 * in the code size value printed by
	 * the linker
	 */
	for (i=0; i<n; i++) {
		dst[i] = 0;
	}
}

typedef struct A A;

struct A {
	char b[2000];
	void (*f)(char*, int);
};

/* The following definition, and the function 'foo' stored into
 * function pointer 'f', will not be removed in --multifile mode,
 * even though all definitions in this file are unused.
 *
 * If the 'const' is removed, the effect remains.
 * Also, if only the initialization of 'b', or 'f', is commented out,
 * the remaining bits won't be removed too.
 */
static const A not_removed = {
	.b= {42},
	.f= foo,
};

const A*
fn_unused2(void)
{
	return &not_removed;
}
