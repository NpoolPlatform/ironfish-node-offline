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
  registry="uhub.service.ucloud.cn/entropypool_private"
fi
sed -i "s/{{IRONFISH_VERSION}}/$version/g" $MY_PATH/Dockerfile

user=`whoami`
if [ "$user" == "root" ]; then
    docker build -t $registry/entropypool/$service_name:$version  .
else
    sudo docker build -t $registry/entropypool/$service_name:$version  .
fi