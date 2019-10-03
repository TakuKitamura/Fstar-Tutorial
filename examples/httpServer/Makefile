# include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	krml -verbose -verify -drop WasmSupport -tmpdir ./out  -no-prefix HttpServer httpServer.fst main.c fstarHelper.c && echo "# ex." && echo "./a.out # Listening on http://localhost" && echo "curl 'http://localhost' # Open other cli-window. And you send http-get-request."
