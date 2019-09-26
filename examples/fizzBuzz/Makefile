# include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	krml -verify -drop WasmSupport -tmpdir ./out -no-prefix fizzBuzz fizzBuzz.fst && ./a.out
	# krml -verify -skip-extraction -skip-translation -skip-compilation  -skip-linking fizzBuzz.fst