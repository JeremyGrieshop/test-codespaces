FROM centos:centos8.3.2011

# Docker Compose version
ARG COMPOSE_VERSION=1.24.0

# This Dockerfile adds a non-root 'vscode' user with sudo access. However, for Linux,
# this user's GID/UID must match your local user UID/GID to avoid permission issues
# with bind mounts. Update USER_UID / USER_GID if yours is not 1000. See
# https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN dnf install -y epel-release && \  
    dnf install -y 'dnf-command(config-manager)' && \
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    dnf install -y docker-ce --nobest && \
    dnf install -y glibc-langpack-en && \
    yum config-manager --set-enabled powertools && \
    dnf group install "Development Tools" -y && \
    dnf --enablerepo=powertools install -y \
    autoconf make libtool \
    nginx npm gdb gdb-gdbserver valgrind valgrind-devel \
    apr-devel apr-util-mysql apr-util-ldap \
    libxml2-devel libxslt-devel libicu-devel \
    elfutils elfutils-devel libunwind-devel \
    httpd-devel mariadb mariadb-devel libdb-devel lmdb-devel \
    libcurl-devel libyaml libyaml-devel \
    python3-pip python3-devel \
    fcgi fcgi-devel wget git \
    rpm-build \
    openssl openssl-devel doxygen && \
    dnf clean all

# make sure NPM/Node are latest stable, along with NPMv7
RUN npm install -g npm-upgrade && npm install -g n && n stable 
RUN npm install -g npm@7

# install python packages
RUN pip3.6 install requests inflection lxml

# Allow bash history to persist between container rebuilds by sending it to a directory that can reside on a persisted volume
# Also, alias ls to show colors by default
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && echo $SNIPPET >> "/root/.bashrc" \
    && echo "alias ls='ls --color=auto'" >> "/root/.bashrc"