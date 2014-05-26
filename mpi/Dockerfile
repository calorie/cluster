FROM phusion/baseimage:latest
NAME mpi

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

RUN apt-get -y update

RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N '' > /dev/null
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
