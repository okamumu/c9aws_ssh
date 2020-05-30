#!/bin/sh

MKHOME_USER=$1
MKHOME_PASSWORD=$2
MKHOME_UID=$3
MKHOME_GROUP=$4
MKHOME_GID=$5
MKHOME_HOME=$6
MKHOME_GRANT_SUDO=$7
MKHOME_RSA=$8

groupadd -f -g $MKHOME_GID $MKHOME_GROUP || exit 1
if [ $MKHOME_PASSWORD = "no" ]; then
  useradd -m -d $MKHOME_HOME -u $MKHOME_UID -g $MKHOME_GID -s /bin/bash $MKHOME_USER || exit 1
else
  useradd -m -d $MKHOME_HOME -u $MKHOME_UID -g $MKHOME_GID -s /bin/bash -p `echo "$MKHOME_PASSWORD" | mkpasswd -s -m sha-512` $MKHOME_USER || exit 1
fi

if [ $MKHOME_GRANT_SUDO = "yes" ]; then
  echo "$MKHOME_USER ALL=(ALL) ALL" >> /etc/sudoers.d/$MKHOME_USER
elif [ $MKHOME_GRANT_SUDO = "nopass" ]; then
  echo "$MKHOME_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$MKHOME_USER
fi

mkdir -p $MKHOME_HOME/.ssh
echo "add RSA $MKHOME_RSA"
echo $MKHOME_RSA > $MKHOME_HOME/.ssh/authorized_keys
chown -R $MKHOME_USER:$MKHOME_GROUP $MKHOME_HOME
chmod 700 $MKHOME_HOME/.ssh
chmod 600 $MKHOME_HOME/.ssh/authorized_keys


