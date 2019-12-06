FROM debian:buster-slim
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    babeltrace \
    bc \
    bison \
    build-essential \
    cmake \
    apt-utils \
    python \
    curl \
    git \
    tree \
    tmux

RUN apt-get install -y \
    verilator iverilog \
    yosys \
    gperf \
    libgmp-dev

WORKDIR /app

RUN groupadd -g 1000 appuser && \
    useradd -r -u 1000 -g appuser appuser
RUN chown appuser.appuser /app

RUN git clone https://github.com/YosysHQ/SymbiYosys.git SymbiYosys
RUN cd SymbiYosys && make install && cd -

RUN git clone https://github.com/SRI-CSL/yices2.git yices2
RUN cd yices2 && autoconf && ./configure && make  -j $(nproc) && make install

 RUN apt-get install -y \
    cmake libblkid-dev e2fslibs-dev libboost-all-dev libaudit-dev

RUN git clone https://github.com/Z3Prover/z3.git z3 && \
    cd z3 && \
    python scripts/mk_make.py && \
    cd build && make -j $(nproc) && make install && cd ../..

RUN apt-get install -y libz-dev

RUN git clone https://github.com/boolector/boolector && \
  cd boolector && \
  ./contrib/setup-btor2tools.sh && \
  ./contrib/setup-lingeling.sh && \
  ./configure.sh && \
  make -C build -j$(nproc)
RUN cd boolector && cp build/bin/boolector /usr/local/bin/ && \
  cp build/bin/btor* /usr/local/bin/ && \
  cp deps/btor2tools/bin/btorsim /usr/local/bin/ && cd -

RUN git clone https://bitbucket.org/arieg/extavy.git && \
  cd extavy && \
  git submodule update --init && \
  mkdir build && cd build && \
  cmake -DCMAKE_BUILD_TYPE=Release .. && \
  make -j $(nproc) && \
  cp avy/src/avy /usr/local/bin/ && \
  cp avy/src/avybmc /usr/local/bin/ && \
  cd ../..

USER appuser

# COPY executable_name .
# ENTRYPOINT ["/app/executable_name"]
