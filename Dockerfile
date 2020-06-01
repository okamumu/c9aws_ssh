From ubuntu:18.04 

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    openssh-server \
    build-essential \
    git \
    wget \
    curl \
    python \
    sudo \
    locales \
    vim \
    ca-certificates \
    tmux \
    nodejs \
    npm \
    sqlite3 \
    whois &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

RUN npm update && npm install -g sqlite3

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN ln -sf /usr/bin/node /usr/local/bin/node

RUN mkdir /var/run/sshd

COPY c9-install.sh /c9-install.sh
RUN HOME=/etc/skel /c9-install.sh

COPY useradd.sh /root/useradd.sh
COPY entrypoint.sh /root/entrypoint.sh

ENV C9UID        2000
ENV C9USER       user
ENV C9PASSWORD   user
ENV C9GID        2000
ENV C9GROUP      user
ENV C9HOME       /home/user
ENV C9GRANT_SUDO   yes
ENV C9RSA        RSApubkey

CMD ["/root/entrypoint.sh"]
