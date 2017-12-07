# 框架概述

1. 后端Xadmin+Django2全家桶（①django；②django-REST-framework；③django-filter；④django-simple-captcha；⑤django-REST-framework-jwt ）项目框架（附注释）
2. 前端webpack+Vue全家桶（①Vue2；②Vue-router；③axios；④Vuex）+Bootstrap3的前端项目框架（附注释）
3. 后端部署脚本使用了fabric，
4. 前端表单验证使用了1000hz-bootstrap-validator，文件上传使用了bootstrap-fileinput，富文本编辑使用了tinyMCE，图片编辑使用了cropper

# 使用说明

1. 后台环境搭建。安装好`Python3.5`或者`Python3.6`，在本项目根目录打开命令行，并输入：`pip install -r python-lib-requirements.txt`（注意，请保证你使用的Django版本要至少为2.0）

2. 前端环境搭建。安装好`node.js`，进入`/front-end-src`目录，打开命令行并输入：`npm install`

3. 数据库生成。修改`/back-end-src/APP_Inventor_case_base/settings.py`中的DATABASES为你自己的Mysql数据库配置，在`/back-end-src`下依次运行`python manage.py makemigrations`和`python manage.py migrate`

4. 启动后台程序，在`/back-end-src`下运行`python manage.py runserver`

5. 启动前端程序，进入进入`/front-end-src`目录，运行`npm run dev`

6. `fabfile`为fabric部署脚本，在根目录下命令行运行`fab 函数名`即可执行对应操作

7. 后台工具脚本说明：

①`./back-end-src/tool_scripts/clean_useless_files.py`用于删除/media下已经失效的用户上传图片文件（完全没有被当前任何数据引用到的）；

②`./back-end-src/tool_scripts/import_category_data.py`用于往数据表中插入案例的类别数据，用于初始化数据库；

③`./back-end-src/tool_scripts/init_migrations.py`用于删除所有的migration文件，然后重新进行`makemigrations`操作；

④`./back-end-src/tool_scripts/backup.py`用于备份数据库；

⑤`./back-end-src/tool_scripts/restore.py`用于利用备份数据进行数据库还原；

⑥`./back-end-src/tool_scripts/switch_setting.py`用于将`./back-end-src/tool_scripts/data/db_backup`目录下制定文件（如`local.py`）替换到`./back-end-src/APP_Inventor_case_base/settings.py`上