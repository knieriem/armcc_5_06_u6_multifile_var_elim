	compiling --multifile main.c partly_used.c unused.c unused2.c unused3.c unused4.c
	linking Build/linker_test_multifile.axf
	Program Size: Code=248 RO-data=2024 RW-data=3656 ZI-data=0  

	compiling separate object file main.c
	compiling separate object file partly_used.c
	compiling separate object file unused.c
	compiling separate object file unused2.c
	compiling separate object file unused3.c
	compiling separate object file unused4.c
	linking Build/linker_test_normal.axf
	Program Size: Code=160 RO-data=20 RW-data=8 ZI-data=0  
