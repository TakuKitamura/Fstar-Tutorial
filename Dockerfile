FROM ubuntu:18.04　
LABEL maintainer="TakuKitamura <takukitamura.io@gmail.com>" \
      updatedAt="最終動作確認: 2019年 10月 3日 木曜日 14時23分49秒 JST"
ENV FSTAR_HOME="/root/fstar" \
    KREMLIN_HOME="/root/kremlin" \
    LANG="ja_JP.UTF-8"
SHELL ["/bin/bash", "-c"]
RUN set -x && \
    echo "Start!" && \
    echo "It takes about 30 minutes." && \
    cd ~ && \
    apt update  && \
    apt install -y vim git make opam m4 wget curl locales lsof && \
    locale-gen ja_JP.UTF-8 && \
    opam init -y && \
    opam install depext -y && \
    opam depext conf-gmp.1 -y && \
    opam install ppx_deriving_yojson zarith pprint menhir sedlex process fix wasm visitors stdint base-num num batteries ulex -y && \
    eval $(opam config env) && \
    wget https://github.com/FStarLang/binaries/raw/master/z3-tested/z3-4.8.5-x64-ubuntu-16.04.zip && \
    unzip z3-4.8.5-x64-ubuntu-16.04.zip && \
    rm -rf z3-4.8.5-x64-ubuntu-16.04.zip && \
    ln -s /root/z3-4.8.5-x64-ubuntu-16.04/bin/z3 /usr/local/bin/ && \
    git clone https://github.com/FStarLang/FStar.git fstar && \
    pushd fstar && \
    make && \
    popd && \
    ln -s /root/fstar/bin/fstar.exe /usr/local/bin/ && \
    git clone https://github.com/FStarLang/kremlin.git && \
    pushd kremlin && \
    make && \
    popd && \
    ln -s /root/kremlin/krml /usr/local/bin/ && \
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
    echo -e "call plug#begin()\nPlug 'TakuKitamura/fstar-kremlin-playground.vim'\ncall plug#end()" > ~/.vimrc && \
    vim -c PlugInstall -c q -c q && \
    git clone https://github.com/TakuKitamura/Fstar-Tutorial.git fstar-tutorial && \
    echo '$(opam config env)' >> ~/.bashrc && \
    source ~/.bashrc && \
    echo "Done!" && \
    exec $SHELL -l
