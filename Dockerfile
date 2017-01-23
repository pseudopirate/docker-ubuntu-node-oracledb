FROM ubuntu:16.04

#install required dependencies
RUN apt-get update && \
    apt-get install -y libaio1 build-essential unzip wget python

#download and install node
RUN  wget https://nodejs.org/dist/v6.9.4/node-v6.9.4.tar.gz && \
     tar -xf node-v6.9.4.tar.gz && \
     cd node-v6.9.4 && \
     ./configure && \
     make && \
     make install && \
     rm -f ../node-v6.9.4.tar.gz

#install oracle client

RUN mkdir -p opt/oracle
COPY ./client/ .
RUN unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
    unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
    mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient && \
    ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so  && \
    ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so && \
    echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig
