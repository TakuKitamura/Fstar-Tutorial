# For実行例
```sh
$ pwd
/hoge/fuga/fstar-tutorial/examples/for
$ make
krml -verify -drop WasmSupport -tmpdir ./out -no-prefix ForString forString.fst && ./a.out
...
All files linked successfully 👍
ABC
ABC
ABC
ABC
ABC
ABC
ABC
ABC
ABC
ABC
r='LOOP DONE!'
krml -verify -drop WasmSupport -tmpdir ./out -no-prefix ForUint32 forUint32.fst && ./a.out
...
All files linked successfully 👍
777
777
777
777
777
777
777
777
777
777
r='LOOP DONE!'
```