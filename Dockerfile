FROM hashicorp/packer:latest

# Define our acceptable ansible version
ENV ANSIBLE_VERSION 2.6.0

# Import a testing edge for more recent pkgs
# RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# update/install a bunch of stuffs for pythons
RUN echo "===> Adding Python runtime..."  && \
    apk --update add python py-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip pycrypto cffi


# Install ansible
RUN echo "===> Installing Ansible..."  && \
    pip install ansible>=${ANSIBLE_VERSION}

## Extra tools
RUN echo "===> Installing extra tools"  && \
    apk --update add sshpass openssh-client rsync

# Cleanup
RUN echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*

# Set a default working dir (nice for bind mounting things inside)
RUN mkdir /build
WORKDIR /build

# Packer needs this set:
# https://github.com/mitchellh/packer/blob/49067e732a66c9f7a87843a2c91100de112b21cc/provisioner/ansible/provisioner.go#L127
ENV USER root

# Set our entrypoint back to the default (gitlab-runner needs this)
ENTRYPOINT ["/bin/sh", "-c"]
