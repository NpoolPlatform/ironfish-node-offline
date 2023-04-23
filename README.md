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
          expression { TAG_FOR == 'test' }
          expression { TAG_FOR == 'prod' }
        }
```

uhub.service.ucloud.cn/entropypool/ironfish@v0.1.70

