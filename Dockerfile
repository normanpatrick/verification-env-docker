FROM debian:buster-slim

RUN apt-get update
RUN apt-get install -y \
    autoconf \
    automake \
    autotools-dev \
    babeltrace \
    bc \
    bison \
    build-essential \
    git
RUN apt-get install -y \
    verilator iverilog
RUN apt-get install -y \
    tree \
    tmux \
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
RUN cd yices2 && autoconf && ./configure && make && make install

USER appuser

# COPY executable_name .
# ENTRYPOINT ["/app/executable_name"]
