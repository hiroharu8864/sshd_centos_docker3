FROM centos
MAINTAINER Hiroharu Tanaka <hiroharu8864@gol.com>

RUN yum install -y passwd openssh openssh-server openssh-clients sudo
# install for chef
RUN yum install -y rsync

# Create USER
RUN useradd jenkins
RUN passwd -f -u jenkins
RUN mkdir -p /home/jenkins/.ssh; chown jenkins /home/jenkins/.ssh; chmod 700 /home/jenkins/.ssh
ADD ./authorized_keys /home/jenkins/.ssh/authorized_keys
RUN chown jenkins /home/jenkins/.ssh/authorized_keys; chmod 600 /home/jenkins/.ssh/authorized_keys

RUN echo "jenkins ALL=(ALL) ALL" >> /etc/sudoers.d/jenkins

# setup sshd
ADD ./sshd_config /etc/ssh/sshd_config
RUN /etc/init.d/sshd start; /etc/init.d/sshd stop

# modify iptable config
RUN sed -ri "s/^IPTABLES_MODULES_UNLOAD=\"yes\"/IPTABLES_MODULES_UNLOAD=\"no\"/" /etc/sysconfig/iptables-config
RUN /etc/init.d/iptables start; /etc/init.d/iptables stop 

# install chef
RUN curl -L https://www.opscode.com/chef/install.sh | bash

EXPOSE 22
CMD /usr/sbin/sshd -D
