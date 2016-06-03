FROM ubuntu:xenial
MAINTAINER Antonio De Marinis <demarinis@eea.europa.eu>

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update \
    && apt-get -y install apt-utils \
    && apt-get -y install \
          build-essential wget unzip perl perl-base perl-modules libsdl-perl \
          libperl-dev libpcre3-dev mesa-utils zlib1g-dev libpng-dev sqlite \
          php7.0-cli php7.0-gd php7.0-xml php7.0-json sudo \
    && cd /tmp \
    && wget http://phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_6.4.0_all.deb \
    && dpkg -i phoronix-test-suite_6.4.0_all.deb \
    && rm -f phoronix-test-suite_6.4.0_all.deb

# Install packages for pts/universe-cli Test Suite
#RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y install yasm bc python autoconf libpopt-dev libaio-dev \
#        libssl-dev libnuma-dev tcl gfortran libfftw3-dev fftw-dev libblas-dev \
#        liblapack-dev cmake cmake-data libboost-all-dev libasio-dev \
#        libboost-iostreams-dev libbz2-dev libjpeg-dev libtiff5-dev freeglut3-dev \
#        libopenmpi-dev openmpi-bin libmpich-dev openjdk-8-jre portaudio19-dev

ADD install-ubuntu-packages.sh /usr/share/phoronix-test-suite/pts-core/external-test-dependencies/scripts/install-ubuntu-packages.sh
ADD phoronix-test-suite.xml /etc/phoronix-test-suite.xml
ADD run.sh /run.sh
RUN chmod a+x /usr/share/phoronix-test-suite/pts-core/external-test-dependencies/scripts/install-ubuntu-packages.sh
RUN chmod a+r /etc/phoronix-test-suite.xml
RUN chmod a+x /run.sh
#RUN export DEBIAN_FRONTEND=noninteractive && /usr/bin/phoronix-test-suite batch-install pts/universe-cli
ENTRYPOINT /run.sh
