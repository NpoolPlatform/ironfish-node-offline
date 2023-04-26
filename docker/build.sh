#!/usr/bin/env bash
MY_PATH=$(cd `dirname $0`;pwd)
cd $MY_PATH

set -o errexit
set -o nounset
set -o pipefail

user=`whoami`
if [ "$user" == "root" ]; then
    docker build -t uhub.service.ucloud.cn/entropypool/ironfish:v1.1.0 .
else
    sudo docker build -t uhub.service.ucloud.cn/entropypool/ironfish:v1.1.0  .
fi