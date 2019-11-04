#!/bin/bash
# 自动拉去git最新代码
while true
do
    # 切换到项目根目录
    cd `pwd`
    # 拉代码
    git pull
    # 重新生成页面
    gitbook build
    # 休眠60s
    sleep 60
done
