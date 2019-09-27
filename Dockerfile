FROM ubuntu:18.04　
LABEL maintainer="TakuKitamura <takukitamura.io@gmail.com>"
ENV FSTAR_HOME /root/fstar
SHELL ["/bin/bash", "-c"]
RUN cd ~ && \
    apt update  && \
    apt install -y vim git make opam m4 wget && \
    opam init -y && \
    opam install depext -y && \
    opam depext conf-gmp.1 -y && \
    opam install ppx_deriving_yojson zarith pprint menhir sedlex process fix wasm visitors stdint base-num num batteries -y && \
    eval $(opam config env) && \
    wget https://github.com/FStarLang/binaries/raw/master/z3-tested/z3-4.8.5-x64-ubuntu-16.04.zip && \
    unzip z3-4.8.5-x64-ubuntu-16.04.zip && \
    ln -s /root/z3-4.8.5-x64-ubuntu-16.04/bin/z3 /usr/local/bin/ && \
    git clone https://github.com/FStarLang/FStar.git fstar && \
    pushd fstar && \
    make && \
    popd && \
    ln -s /root/fstar/bin/fstar.exe /usr/local/bin/ && \
    echo "export FSTAR_HOME=/root/fstar" >> ~/.bashrc && \
    source ~/.bashrc && \
    git clone https://github.com/FStarLang/kremlin.git && \
    pushd kremlin && \
    make && \
    popd && \
    ln -s /root/kremlin/krml /usr/local/bin/ && \
    echo "export KREMLIN_HOME=/root/kremlin" >> ~/.bashrc && \
    source ~/.bashrc && \
    git clone https://github.com/TakuKitamura/Fstar-Tutorial.git fstar-tutorial && \
    pushd fstar-tutorial && \
    ./setup.bash && \
    popd
