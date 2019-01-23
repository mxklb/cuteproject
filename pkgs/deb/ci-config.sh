#!/bin/bash
# This is called by gitlab ci runner only!
# Its a ubuntu trusty patch --> Set env USER

ubuntu=$(lsb_release -c | awk '{ print $NF }')

if [ "$ubuntu" = "trusty" ]; then
  echo "hid it .."
  export USER=$GITLAB_USER_LOGIN
  export DEBFULLNAME=$USER
fi
echo $USER
