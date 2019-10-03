# Fstar-Tutorial
F* のチュートリアルです｡ (作成中)

##### bash記号の意味
- $ ･･･ ユーザローカル内
- \# ･･･ dockerコンテナ内

### こちらで用意した､Dockerで楽をする場合(初めはこちらをおすすめ)
- fstar: https://github.com/FStarLang/FStar
- kremlin: https://github.com/FStarLang/kremlin
- z3: https://github.com/FStarLang/binaries
- fstar-kremlin-playground.vim(F*, Kremlin 用に自作した､Vimプラグイン): https://github.com/TakuKitamura/fstar-kremlin-playground.vim

が同梱済みです｡

動画版はこちらです｡ 約9分ほどの動画です｡
[![asciicast](https://asciinema.org/a/SwSBmd5d7xcHVRlL22frB1TX8.svg)](https://asciinema.org/a/SwSBmd5d7xcHVRlL22frB1TX8)

- docker: http://docs.docker.jp/engine/installation/index.html

｢Docker Community 版｣を各々の環境に合わせて､インストールしてください｡macOS, Windows10, 有名 Linuxディストーションなどには対応しています｡
インストール方法などは､各自お調べください｡
```sh
$ docker -v
Docker version 19.03.2, build 6a30dfc
```
インストール後､dockerがインストールされており､起動していることを確認してください｡

```sh
$ docker pull takukitamura/fstar-tutorial-image:1.0.1
$ docker run -it takukitamura/fstar-tutorial-image:1.0.1 /bin/bash
# cd
# pwd
/root
# cd fstar-tutorial
# make test # などなど､あとはご自由にお使いください｡
# # F*, Kremlin 用に自作した､Vimプラグインの使い方に関しては https://github.com/TakuKitamura/fstar-kremlin-playground.vim をご参照ください｡
# # もし､fstar-tutorialに更新があれば､fstar-tutorialディレクトリで､ $ git pull をしてください｡
```

### 自力で､環境構築する場合
- fstar: https://github.com/FStarLang/FStar
- kremlin: https://github.com/FStarLang/kremlin
- z3: https://github.com/FStarLang/binaries
- fstar-kremlin-playground.vim(option, F*, Kremlin 用に自作した､Vimプラグイン): https://github.com/TakuKitamura/fstar-kremlin-playground.vim

ドキュメント参照の上､それぞれをインストールしてください｡
このプロジェクト内の､Dockerfile も参考になるかもしれません｡

```sh
$ fstar.exe --version
F* 0.9.7.0-alpha1
platform=Darwin_x86_64
compiler=OCaml 4.07.1
date=2019-08-01 06:16:43 +0000 
commit=56fae60d880cc7bea2135be5331e37ce681b1d7b
$ krml | head -3 # バージョンを表示するためのオプションがなさそう｡ gitTag が v0.9.6.0 のもの
KreMLin: from a ML-like subset to C

Usage: krml [OPTIONS] FILES
$ z3 --version
Z3 version 4.8.5 - 64 bit
```
などで上記､3つの動作が確認できれば､多分動く｡
ただ､環境依存があるので､詳細は公式ドキュメント参照｡

### サンプルコードの実行方法
```sh
# pwd
/hoge/fuga/hoge/Fstar-Tutorial
# make test # 全てのサンプルコードを実行
# pushd examples/[fizzBuzz | for | httpProtocolMock | mailHeaderParse | ...] # どれかのディレクトリ
# make # 個別に実行
# popd
```


### 自分でDockerイメージを作成したい場合

DockerImage作成の様子はこちら  約40分ほどの動画です｡
[![asciicast](https://asciinema.org/a/6XXdzbsUXLo8xjcHZtMfZ8qQ0.svg)](https://asciinema.org/a/6XXdzbsUXLo8xjcHZtMfZ8qQ0)

```sh
$ pwd
/hoge/fuga/hoge/Fstar-Tutorial
$ # もし､初期状態を変更したい場合､ Dockerfileをお好みで修正してください｡
$ docker build -t my-fstar-tutorial-image . # などで､イメージを作成してください｡ 当方環境では､約40分かかりました｡
$ docker run -it my-fstar-tutorial-image /bin/bash # 起動
```

### トラブルシューティング
もし､コンパイル中に､以下のような､ocaml関連のエラーが出たら､依存関係が壊れている可能性があるので､
```sh
# make
...
ocamlfind: Package `batteries' not found - required by `fstarlib'
Makefile:4: recipe for target 'all' failed
make[1]: *** [all] Error 2
```

```sh
# eval $(opam config env)
[WARNING] Running as root is not recommended
```
というコマンドを実行してください｡