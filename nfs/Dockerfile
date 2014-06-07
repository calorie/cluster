FROM phusion/baseimage:latest
NAME nfs

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init", "--enable-insecure-key"]

RUN apt-get -y update

RUN apt-get install -y curl

ENV CHEFHOME /chef-repo
ADD chef-repo /chef-repo

RUN curl -L http://www.opscode.com/chef/install.sh | bash
RUN cd ${CHEFHOME} && chef-solo -c ${CHEFHOME}/solo.rb -j ${CHEFHOME}/nodes/nfs.json

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
