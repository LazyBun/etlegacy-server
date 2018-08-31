FROM ubuntu:14.04
MAINTAINER Krzysztof Piszko <krzysztof@piszkod.pl>

ENV ETL_PATH /root/etlegacy
 
RUN apt-get update -y && apt-get install -y wget
RUN wget -O etlegacy-v2.75-x86_64.tar.gz https://www.etlegacy.com/download/file/87 \
&& tar -xzf etlegacy-v2.75-x86_64.tar.gz && rm -f etlegacy-v2.75-x86_64.tar.gz \
&& mv etlegacy-v2.75-x86_64 $ETL_PATH

ENV PAK_MIRROR www.harryhomers.org/et/download/etmain/

WORKDIR $ETL_PATH/etmain

RUN wget http://$PAK_MIRROR/pak0.pk3 \
&& wget http://$PAK_MIRROR/pak1.pk3

COPY etl_server.cfg /root/etlegacy/etmain/

EXPOSE 27960:27960/udp

WORKDIR $ETL_PATH
ENTRYPOINT ./etlded_bot.sh
