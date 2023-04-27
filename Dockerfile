FROM multiarch/qemu-user-static:x86_64-aarch64 as qemu
FROM arm64v8/alpine:latest
COPY --from=qemu /usr/bin/qemu-aarch64-static /usr/bin

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

ADD idle.sh /idle.sh

# Install.
RUN \
  apk add --no-cache bash vim less net-tools busybox-extras proftpd openrc

# Add user cisco with password cisco - please change this in production
RUN adduser -D cisco \
  && echo 'cisco:cisco' | chpasswd

RUN rc-update add proftpd default 

RUN rc-update add devfs sysinit \ 
 && rc-update add dmesg sysinit 

RUN rc-update add hwclock boot \
 && rc-update add modules boot \
 && rc-update add sysctl boot \
 && rc-update add hostname boot \
 && rc-update add bootmisc boot 

RUN rc-update add mount-ro shutdown \
 && rc-update add killprocs shutdown \
 && rc-update add savecache shutdown

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD ["bash", "/idle.sh"]

EXPOSE 20-21
EXPOSE 65500-65515
