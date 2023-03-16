# ironfish-node-offline

jenkinsfile 中支持三个step：build、release、deploy，三个step控制变量分别为BUILD_TARGET、RELEASE_TARGET、DEPLOY_TARGET（设置为true触发step）

三个step都支持两个参数IRONFISH_VERSION、DOCKER_REGISTRY

参数可选范围如下，其中第一个为默认值，当给空值时会自动使用默认值

IRONFISH_VERSION：v0.1.70

DOCKER_REGISTRY：uhub.service.ucloud.cn/entropypool、docker.io/orginazation_name

