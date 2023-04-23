#!/usr/bin/env bash
MY_PATH=$(cd `dirname $0`;pwd)
cd $MY_PATH

set -o errexit
set -o nounset
set -o pipefail

user=`whoami`
if [ "$user" == "root" ]; then
    docker push uhub.service.ucloud.cn/entropypool/ironfish:v1.0.1
else
    sudo docker uhub.service.ucloud.cn/entropypool/ironfish:v1.0.1
fi