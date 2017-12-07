#!/bin/bash

# 获取该脚本文件本身的绝对路径（必须在cd前执行此操作，因为.和..依赖于当前工作目录，必须在没改变前获取之）
script_file_path=$(readlink -f $0)
base_dir=$(dirname ${script_file_path})
switch_fabfile_env_script_path=${base_dir}"/switch_fabfile_env.py"
switch_setting_script_path=${base_dir}"/back-end-src/tool_scripts/switch_setting.py"
python "${switch_fabfile_env_script_path}" "github"
python "${switch_setting_script_path}" "initial"
git "add" "."
git "commit" "-m" "$1"
git "push" "origin" "master"
python "${switch_fabfile_env_script_path}" "production"
python "${switch_setting_script_path}" "local"