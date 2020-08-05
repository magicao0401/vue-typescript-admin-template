#!/bin/bash

#环境变量
APP_ENV='dev'

# 仓库及镜像定义
DOCKER_NAME="webadmin-${APP_ENV}" # 需修改
DOCKER_FILE="./Dockerfile"
REPO_DOMAIN="mcregistry.azurecr.cn"


# 镜像版本
VERSION=$1
if [ ! -n "$1" ];then
  VERSION=`date '+%Y%m%d%H%M%S'`
fi

ZIP_FILE="./docker/${APP_ENV}/dist.zip"

if [ -f "$ZIP_FILE" ]; then 
	rm "$ZIP_FILE";
fi

# 打包(需修改)
npm install
npm run build

(cd dist && zip -r -q ../"$ZIP_FILE" * -x 'node_modules/*' '.*' '*.yml')

# 删除原有本地最新版本镜像
# docker rmi "$DOCKER_NAME:latest"
docker images | grep "$REPO_DOMAIN/$DOCKER_NAME" | awk '{print $3}'| xargs docker rmi

# 生成docker镜像
docker build -t "$DOCKER_NAME:latest" -f $DOCKER_FILE .

# 打docker镜像tag
docker tag "$DOCKER_NAME:latest" "$REPO_DOMAIN/$DOCKER_NAME:$VERSION"

# pus
docker push "$REPO_DOMAIN/$DOCKER_NAME:$VERSION"






