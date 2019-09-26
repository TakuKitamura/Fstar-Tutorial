FROM ubuntu:18.04　
LABEL maintainer="TakuKitamura <takukitamura.io@gmail.com>"
ENV FSTAR_HOME /root/fstar
SHELL ["/bin/bash", "-c"]
RUN cd ~ && \
    apt update  && \
    apt install -y vim git make opam m4 wget && \
    wget https://github.com/FStarLang/FStar/releases/download/V0.9.7.0-alpha1/fstar_0.9.7.0-alpha1_Linux_x86_64.tar.gz && \
    tar -zxvf fstar_0.9.7.0-alpha1_Linux_x86_64.tar.gz && \
    cp fstar/bin/fstar.exe /usr/local/bin/ && \
    opam init -y && \
    opam install depext -y && \
    opam depext conf-gmp.1 -y && \
    opam install ppx_deriving_yojson zarith pprint menhir sedlex process fix wasm visitors -y && \
    eval $(opam config env) && \
    git clone https://github.com/FStarLang/kremlin.git && \
    pushd kremlin && \
    make -j 6 && \
    cp krml /usr/local/bin/ && \
    popd && \
    git clone https://github.com/TakuKitamura/Fstar-Tutorial.git fstar-tutorial && \
    pushd fstar-tutorial && \