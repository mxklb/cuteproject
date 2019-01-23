#!/bin/bash
# This is called by gitlab ci runner only!
# Its a ubuntu trusty patch --> Set env USER

ubuntu=$(lsb_release -c | awk '{ print $NF }')

if [ "$ubuntu" = "trusty" ]; then
  USER=$GITLAB_USER_LOGIN
  DEBFULLNAME=$GITLAB_USER_LOGIN
fi
echo $USER
