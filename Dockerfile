FROM ubuntu:16.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin && apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-all-dev
RUN apt-get install -y libminiupnpc-dev
RUN apt-get install -y git supervisor
RUN apt-get install -y automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev

RUN git clone https://github.com/ocminer/cpuminer-xzc

RUN cd /cpuminer-xzc && ./build.sh
RUN cd /cpuminer-xzc && make
COPY run_miner.sh /cpuminer-xzc/run_miner.sh
RUN chmod +x /cpuminer-xzc/run_miner.sh

EXPOSE 5595

COPY wallet.dat /root/.zcoin/wallet.dat
#ADD start_miner.sh /z/src
#RUN chmod 755 /zcoin/src/start_miner.sh

WORKDIR /cpuminer-xzc
#RUN /cpuminer-multi/cpuminer --help

#RUN /zcoin/src/zcoind --daemon
#RUN /zcoin/src/zcoind setgenerate true 30
#RUN tail -f /dev/null
#ENTRYPOINT ["/zcoin/src/zcoind --daemon"]
#CMD ["/zcoin/src/start_miner.sh"]
