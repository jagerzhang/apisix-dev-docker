# apisix-dev-docker
基于Docker 开箱即用的 APISIX 开发环境。

## 使用方法

### 构建镜像
```shell
git clone https://github.com/jagerzhang/apisix-dev-docker.git
cd apisix-dev-docker
docker build -t apisix:dev ./
```
**此镜像已长传到 [DockerHub](https://hub.docker.com/r/jagerzhang/apisix-dev)，可以也可以直接拉取使用**
```shell
docker pull jagerzhang/apisix-dev:latest
```

### 当本地已有 apisix 代码时
```shell
docker run --rm -ti -v <apisix代码目录>:/opt/apisix apisix:dev bash

# 进入容器后，可以直接运行测试用例，比如：
prove -I/opt/test-nginx/lib -r t/plugin/consumer-restriction.t

# 也可以用于 apisix 开发，如需暴露HTTP端口请启动容器加上端口映射
# make init
# make run
```

### 当面本地没有 apisix 代码时

```shell
# 克隆代码
git clone https://github.com/apache/apisix.git
# 拉取submodule代码（必做）
git submodule update --init --recursive
# 挂载代码运行容器
docker run --rm -ti -v `pwd`/apisix:/opt/apisix apisix:dev bash
# 自动 make deps，等待一段时间即可

# 完成后，可以直接运行测试用例，比如：
prove -I/opt/test-nginx/lib -r t/plugin/consumer-restriction.t

# 也可以用于 apisix 开发，如需暴露HTTP端口请启动容器加上端口映射
# make init
# make run
```

### 实例预览
```shell
[root@localhost ~]# git clone https://github.com/apache/apisix.git
Cloning into 'apisix'...
remote: Enumerating objects: 23066, done.
remote: Counting objects: 100% (2058/2058), done.
remote: Compressing objects: 100% (907/907), done.
remote: Total 23066 (delta 1342), reused 1538 (delta 964), pack-reused 21008
Receiving objects: 100% (23066/23066), 22.97 MiB | 2.36 MiB/s, done.
Resolving deltas: 100% (16976/16976), done.

[root@localhost ~]# cd apisix

[root@localhost ~]# git submodule update --init --recursive
Submodule '.github/actions/action-tmate' (https://github.com/mxschmitt/action-tmate) registered for path '.github/actions/action-tmate'
Submodule 't/toolkit' (https://github.com/api7/test-toolkit.git) registered for path 't/toolkit'
Cloning into '.github/actions/action-tmate'...
remote: Enumerating objects: 347, done.
remote: Counting objects: 100% (76/76), done.
remote: Compressing objects: 100% (48/48), done.
remote: Total 347 (delta 35), reused 50 (delta 20), pack-reused 271
Receiving objects: 100% (347/347), 811.76 KiB | 63.00 KiB/s, done.
Resolving deltas: 100% (152/152), done.
Submodule path '.github/actions/action-tmate': checked out '079a16b22b8bcc5dd231a42d9a5e8e48db564688'
Cloning into 't/toolkit'...
remote: Enumerating objects: 21, done.
remote: Counting objects: 100% (21/21), done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 21 (delta 8), reused 12 (delta 5), pack-reused 0
Unpacking objects: 100% (21/21), done.
Submodule path 't/toolkit': checked out 'ab2471cc9cbeec6fe605120160eeb9dd17ddda2c'

[root@localhost ~]# docker run --rm -ti -v `pwd`/apisix:/opt/apisix apisix:dev bash
root         6  0.0  0.0 124652  3968 pts/0    Rl+  13:19   0:00 etcd
root         8  0.0  0.0   9092   672 pts/0    S+   13:19   0:00 grep etcd
root         9  0.0  0.0   9092   672 pts/0    S+   13:19   0:00 grep etcd
ETCD Start success
Found apisix source code in /opt/apisix, make init, Plz Wait...
## make deps 过程略...

./bin/apisix init
/usr/local/openresty/luajit/bin/luajit ./apisix/cli/apisix.lua init
./bin/apisix init_etcd
/usr/local/openresty/luajit/bin/luajit ./apisix/cli/apisix.lua init_etcd

init success.

current you can:

run `prove -I/opt/test-nginx/lib -r /opt/apisix/t/plugin/<xxx.t>` to run a specified test case;
run `prove -I/opt/test-nginx/lib -r /opt/apisix/t .` to run all test case

[root@d84cc0d039ba apisix]# prove -I/opt/test-nginx/lib -r t/plugin/consumer-restriction.t 
t/plugin/consumer-restriction.t .. ok     
All tests successful.
Files=1, Tests=159, 11 wallclock secs ( 0.03 usr  0.00 sys +  1.87 cusr  0.29 csys =  2.19 CPU)
Result: PASS
[root@d84cc0d039ba apisix]# 
```
