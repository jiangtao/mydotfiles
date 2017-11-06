#!/bin/bash

sudo apt-get update 
sudo apt-get install python-pip 
export LC_ALL=C 
pip install --upgrade pip
sudo ssserver -d start -k yourpassword
# 启动命令记得添加到开机项
