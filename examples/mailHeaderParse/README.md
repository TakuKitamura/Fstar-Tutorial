# MailHeaderParse実行例
```sh
$ pwd
/hoge/fuga/fstar-tutorial/examples/mailHeaderParse
$ make
fstar.exe mailHeaderParse.fst --odir out --codegen OCaml --extract 'mailHeaderParse'  --debug 'MailHeaderParse' --detail_errors --debug_level Medium
...
./a.out
---DATA FROM CLIENT---
FROM: example2@icloud.com
To: example2@gmail.com
Subject: Test

Hello!!
...
Good by!!
.
----------------------
3
17
20
subStr example@mail.com
```