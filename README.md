# ironfish-node-offline

jenkinsfile 中有三个step：build -> release -> deploy （每次改动最好按照build release deploy的顺序依次执行进行部署）

jenkinsfile 为项目打Tag，支持以下变量

```text
        anyOf{
          expression { TAG_MAJOR == 'true' }
          expression { TAG_MINOR == 'true' }
          expression { TAG_PATCH == 'true' }
        }
        anyOf{
          expression { TAG_FOR == 'testing' }
          expression { TAG_FOR == 'production' }
        }
```

uhub.service.ucloud.cn/entropypool/ironfish@v0.1.70

## 升级版本

仓库内容较简单，直接替换版本号即可

