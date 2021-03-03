FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -y git-core

RUN apt-get install -y wget build-essential libssl-dev libncurses5-dev unzip gawk zlib1g-dev subversion mercurial

RUN git clone https://github.com/openwrt/chaos_calmer.git

COPY /.config /chaos_calmer/.

WORKDIR /chaos_calmer 

RUN ./scripts/feeds update -a
RUN ./scripts/feeds install -a

RUN make toolchain/install

RUN export PATH=/chaos_calmer/staging_dir/host/bin:$PATH

ENTRYPOINT bash
