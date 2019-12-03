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

# WORKDIR /app
# COPY executable_name .
# ENTRYPOINT ["/app/executable_name"]
