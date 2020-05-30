#!/bin/bash

/root/useradd.sh $C9USER $C9PASSWORD $C9UID $C9GROUP $C9GID $C9HOME $C9GRANT_SUDO "$C9RSA"

/usr/sbin/sshd -D
