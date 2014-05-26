FROM phusion/baseimage:latest
NAME mpi_client

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init", "--enable-insecure-key"]

RUN apt-get update

RUN ssh-keygen -f /root/.ssh/id_rsa -t rsa -N '' > /dev/null
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN apt-get install -y curl
ENV CHEFHOME /chef-repo
ADD chef-repo /chef-repo

RUN curl -L http://www.opscode.com/chef/install.sh | bash
RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/mpi_client.json
