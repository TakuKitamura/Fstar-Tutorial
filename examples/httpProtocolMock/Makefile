# include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	krml -verbose -verify -drop WasmSupport -tmpdir ./out  -no-prefix HttpProtocolMock httpProtocolMock.fst httpCliantMock.c funcHelpers.c && echo 'ex: ./httpProtocolMock.sh "GET" "/"'
	./httpProtocolMock.sh "GET" "/"
