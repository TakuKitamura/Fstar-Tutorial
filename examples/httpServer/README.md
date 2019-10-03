# HttpServer実行例
```sh
$ pwd
/hoge/fuga/fstar-tutorial/examples/httpServer
$ make
krml -verbose -verify -drop WasmSupport -tmpdir ./out  -no-prefix HttpServer httpServer.fst main.c fstarHelper.c
...
All files linked successfully 👍
# ex.
./a.out # Listening on http://localhost
curl 'http://localhost' # Open other cli-window. And you send http-get-request.
$ ./a.out # if you would like stop http-server, you  should input ctrl-c.
$ curl 'http://localhost' # Open other cli-window.
<html><h1>Hi.<br>It works!</h1></html>
```