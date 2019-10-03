# include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	krml -verbose -verify -drop WasmSupport -tmpdir ./out  -no-prefix HttpServer httpServer.fst main.c fstarHelper.c && ./a.out
