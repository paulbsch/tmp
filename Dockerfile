#FROM ppc64le/ubuntu:xenial
#FROM nimbix/ubuntu-base
#FROM nimbix/ubuntu-base:xenial
FROM ubuntu:xenial
#

ENV TESTENV teststring
RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/paulbsch/image-common/master/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop

#RUN dpkg-divert --local --rename --add /sbin/initctl
#RUN ln -s /bin/true /sbin/initctl

EXPOSE 22

ADD AppDef.json /etc/NAE/AppDef.json
ADD test.sh /usr/local/bin/test.sh

#RUN rm -f /usr/sbin/policy-rc.d /sbin/initctl && \
#    dpkg-divert --rename --remove /sbin/initctl

ENV TESTDIR /opt/ristretto_fpga/xlnx-i2c/runtime/platforms/xilinx_xil-accel-rd-ku115_4ddr-xpr_3_3/driver/
RUN mkdir -p $TESTDIR
RUN touch $TESTDIR/libxcldrv.so $TESTDIR/xcldma.zip $TESTDIR/xclhal.zip


