#!/usr/bin/env bash
MY_PATH=$(cd `dirname $0`;pwd)
ROOT_PATH=$(cd $MY_PATH/../;pwd)
cd $MY_PATH

set -o errexit
set -o nounset
set -o pipefail

user=`whoami`
if [ "$user" == "root" ]; then
    kubectl apply -k $ROOT_PATH/k8s/
else
    sudo kubectl apply -k $ROOT_PATH/k8s/
fi
