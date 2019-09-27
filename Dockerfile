FROM ubuntu:18.04　
LABEL maintainer="TakuKitamura <takukitamura.io@gmail.com>" \
      updatedAt="2019年 9月27日 金曜日 19時17分22秒 JST"
ENV FSTAR_HOME /root/fstar
SHELL ["/bin/bash", "-c"]
RUN set -x && \
    echo "Start!" && \
    echo "It takes about 30 minutes." && \
    cd ~ && \
    apt update  && \
    apt install -y vim git make opam m4 wget curl && \
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
    git clone https://github.com/TakuKitamura/Fstar-Tutorial.git fstar-tutorial && \
    pushd fstar-tutorial && \
    ./setup.bash && \
    popd && \
    vim -c PlugInstall -c q -c q && \
    echo "Done!"
