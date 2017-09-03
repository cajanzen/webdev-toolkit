FROM phusion/baseimage:0.9.22
# version list: https://github.com/phusion/baseimage-docker/releases
MAINTAINER Carl Janzen <carl.janzen@gmail.com>

RUN apt-get update && apt-get install -y \
  build-essential \
  python3-venv \
  rsync \
  git \
  && rm -rf /var/lib/apt/lists/* 

# Node
ENV NVM_VERSION "0.33.2"
ENV NVM_DIR "/opt/nvm"
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash
ENV NODE_VERSION "8.4"
RUN . ${NVM_DIR}/nvm.sh ; nvm install ${NODE_VERSION}

# Ruby
RUN \curl -sSL https://get.rvm.io | bash -s stable --with-default-gems="gem bundler"
RUN /usr/local/rvm/bin/rvm install ruby

# enable ssh
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
COPY id_rsa.pub /tmp/your_key.pub
RUN cat /tmp/your_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/your_key.pub

RUN echo "nvm use node ; rvm use ruby " >> /root/.profile
CMD ["/sbin/my_init"]

