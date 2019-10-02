# include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	krml -verify -drop WasmSupport -tmpdir ./out -no-prefix FizzBuzz fizzBuzz.fst callFizzBuzz.c && ./a.out