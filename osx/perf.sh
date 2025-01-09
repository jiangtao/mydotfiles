#!/bin/bash

# 检查是否提供了输入文件参数
if [ $# -lt 1 ]; then
  echo "用法: $0 <输入视频文件>"
  exit 1
fi

# 输入文件
input_file="$1"

# 检查输入文件是否存在
if [ ! -f "$input_file" ]; then
  echo "错误: 输入文件 '$input_file' 不存在"
  exit 1
fi

# 从输入文件名解析出输出目录
# 首先去掉文件扩展名
base_name="${input_file%.*}"

# 将 '-' 替换为 '/' 以构建目录结构
output_dir="${base_name//-//}"

# 输出文件格式
output_format="%04d.png"

# 检查输出目录是否存在，如果存在则清空，不存在则创建
if [ -d "$output_dir" ]; then
  rm -rf "$output_dir"/*
else
  mkdir -p "$output_dir"
fi

# 运行 ffmpeg 命令, 17ms每帧
ffmpeg -i "$input_file" -vf "fps=58.8235" "$output_dir/$output_format"
