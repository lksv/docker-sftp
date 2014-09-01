# sshd
#
# VERSION               0.0.1

FROM     ubuntu:14.10
MAINTAINER Lukas Svoboda "lukas.svoboda@gmail.com"

RUN export DEBIAN_FRONTEND=noninteractive
ENV DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl

RUN apt-get update && apt-get install -y openssh-server ca-certificates
RUN mkdir /var/run/sshd

EXPOSE 22

RUN sudo echo "ChrootDirectory /sftp" >> /etc/ssh/sshd_config
RUN sudo echo "AllowTCPForwarding no" >> /etc/ssh/sshd_config
RUN sudo echo "X11Forwarding no" >> /etc/ssh/sshd_config
RUN sudo echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config

RUN sudo sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sudo sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

RUN sudo mkdir -p /var/run/sshd
RUN sudo chmod -rx /var/run/sshd

RUN sudo chown root:root /etc/ssh/sshd_config

ADD start.sh /start.sh
RUN chmod 0755 /start.sh
CMD    /start.sh
