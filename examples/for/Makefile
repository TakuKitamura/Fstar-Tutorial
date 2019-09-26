# include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	krml -verify -drop WasmSupport -tmpdir ./out -no-prefix ForString forString.fst && ./a.out
	krml -verify -drop WasmSupport -tmpdir ./out -no-prefix ForUint32 forUint32.fst && ./a.out