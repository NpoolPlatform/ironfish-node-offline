#!/usr/bin/env bash
MY_PATH=$(cd `dirname $0`;pwd)
ROOT_PATH=$(cd $MY_PATH/../;pwd)
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

sed -i "s#{{registry}}#$registry#g" $ROOT_PATH/k8s/02-ironfish-node-offline.yaml
sed -i "s#{{version}}#$version#g" $ROOT_PATH/k8s/02-ironfish-node-offline.yaml

user=`whoami`
if [ "$user" == "root" ]; then
    kubectl apply -k $ROOT_PATH/k8s/
else
    sudo kubectl apply -k $ROOT_PATH/k8s/
fi
