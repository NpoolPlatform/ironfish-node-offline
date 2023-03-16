#!/usr/bin/env bash
MY_PATH=$(cd `dirname $0`;pwd)
cd $MY_PATH

set -o errexit
set -o nounset
set -o pipefail

service_name=ironfish
## For development environment, pass the second variable
if [ "x" == "x$version" ]; then
  version="v0.1.70"
fi

if [ "x" == "x$registry" ]; then
  registry="uhub.service.ucloud.cn/entropypool"
fi

user=`whoami`
if [ "$user" == "root" ]; then
    docker build -t $registry/$service_name:$version --build-arg IRONFISH_VERSION="$version" .
else
    sudo docker build -t $registry/$service_name:$version --build-arg IRONFISH_VERSION="$version" .
fi
