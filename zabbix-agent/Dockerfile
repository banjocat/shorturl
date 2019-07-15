FROM zabbix/zabbix-agent:ubuntu-4.0-latest

RUN apt-get update
RUN apt-get install -y \
    git \
    sudo \
    ksh


RUN git clone https://github.com/sergiotocalini/zapgix.git
RUN sudo ./zapgix/deploy_zabbix.sh
