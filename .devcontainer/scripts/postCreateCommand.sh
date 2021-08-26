#!/bin/bash

if [ ! -e /afw/afw.conf ]; then
  echo "Initializing persistent volume at /afw"

  cp -r docker/dev/* /afw

  # grab the working directory
  workspaceRoot=`pwd | sed 's/\//\\\\\//g'`

  # change the directory path for the 'dev' adaptor
  sed -i "s/\/workspace/$workspaceRoot/" /afw/config/_AdaptiveServiceConf_/adaptor-dev.json 
fi

echo "Container created."