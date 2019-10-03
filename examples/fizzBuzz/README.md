# FizzBuzz実行例
```sh
$ pwd
/hoge/fuga/fstar-tutorial/examples/fizzBuzz
$ make
krml -verify -drop WasmSupport -tmpdir ./out -no-prefix FizzBuzz fizzBuzz.fst callFizzBuzz.c && ./a.out
...
All files linked successfully 👍
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
Fizz
22
23
Fizz
Buzz
26
Fizz
28
29
FizzBuzz
```