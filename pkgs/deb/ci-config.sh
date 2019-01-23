#!/bin/bash
# This is called by gitlab ci runner only!
# Its a ubuntu trusty patch --> Set env USER

ubuntu=$(lsb_release -c | awk '{ print $NF }')

if [ "$ubuntu" = "trusty" ]; then
  export USER=$GITLAB_USER_LOGIN
fi
