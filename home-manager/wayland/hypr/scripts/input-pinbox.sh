#!/usr/bin/env bash
read -p $'请输入内容:\n' input
echo $input | wl-copy -n
