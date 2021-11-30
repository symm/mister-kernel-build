FROM ubuntu:18.04

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install build-essential git libncurses-dev \
    flex bison openssl libssl-dev dkms libelf-dev libudev-dev \
    libpci-dev libiberty-dev autoconf liblz4-tool bc curl gcc \
    git libssl-dev libncurses5-dev lzop make u-boot-tools
##########
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get -y update
#########
ARG DEBIAN_FRONTEND=noninteractive
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone
###########
RUN apt-get -y build-dep linux

RUN apt-get -y install wget
RUN wget -c https://releases.linaro.org/components/toolchain/binaries/6.5-2018.12/arm-linux-gnueabihf/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz

RUN cat gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf.tar.xz | sudo bash -c 'cd /opt ; tar xJ'
RUN chown -R root:root /opt/gcc-linaro-6.5.0-2018.12-x86_64_arm-linux-gnueabihf

RUN mkdir -p /mister

WORKDIR /mister

VOLUME ['/mister']

ENTRYPOINT ["tail", "-f", "/dev/null"]
