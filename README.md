# Fstar-Tutorial
F* のチュートリアルです｡ (作成中)

### 必須ツール
- fstar
- kremlin
- z3

### セットアップ
fstar, kremlin, z3 のセットアップについては
- fstar: https://github.com/FStarLang/FStar
- kremlin: https://github.com/FStarLang/kremlin
- z3: https://github.com/FStarLang/binaries

### サンプルコードの実行
```sh
$ pwd
/Users/fuga/hoge/Fstar-Tutorial
$ make test # 全てのサンプルコードを実行
$ pushd examples/[fizzBuzz | for | httpProtocolMock | mailHeaderParse | ...] # どれかのディレクトリ
$ make # 個別に実行
$ popd
```

