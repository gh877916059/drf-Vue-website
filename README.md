# 一、网站效果展示：
①公共模块（包括标题logo、搜索框、登录与注册按钮、页面导航栏，位于各个页面的顶部）：
 ![公共模块](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/公共模块.png)
 
②首页：
 ![首页1](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/首页1.png)
 
![首页2](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/首页2.png)

③案例详情页：
 ![案例详情页](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/案例详情页.png)

④案例编辑页：
 
![案例编辑页1](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/案例编辑页1.png)
 
![案例编辑页2](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/案例编辑页2.png)
 
 ![案例编辑页3](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/案例编辑页3.png)

⑤问题相关页面：
 ![问题相关页面](https://github.com/gh877916059/drf-Vue-website/raw/master/pictures/问题相关页面.png)

# 二、后端项目（back-end-src目录）

## 1. 架构说明

1. Xadmin+Django2全家桶（①django；②django-REST-framework；③django-filter；④django-simple-captcha；⑤django-REST-framework-jwt；⑥django-favicon）

## 2. 使用教程（下面的命令皆以back-end-src为当前目录运行）

1. 环境搭建。安装好`Python3.5`或者`Python3.6`后，命令行运行`pip install -r python-lib-requirements.txt`（注意，请保证你使用的Django版本要至少为2.0）
2. 数据库生成。修改`APP_Inventor_case_base/settings.py`中的DATABASES为你自己的Mysql数据库配置，在`/back-end-src`下依次运行`python manage.py makemigrations`和`python manage.py migrate`
3. 启动后台程序，命令行运行`python manage.py runserver`

## 3. 工具脚本说明：

①`tool_scripts/clean_useless_files.py`用于删除/media下已经失效的用户上传图片文件（完全没有被当前任何数据引用到的）；

②`tool_scripts/import_data.py`用于往数据表中插入预设数据（存放于`tool_scripts/data/wait_to_import`目录当中），用于初始化数据库；

③`tool_scripts/switch_setting.py`用于将`tool_scripts/data/db_backup`目录下制定文件（如`local.py`）替换到`APP_Inventor_case_base/settings.py`上

# 三、前端项目（front-end-src目录）

## 1. 架构说明

1. 项目整体使用TypeScript（它是JavaScript的一个超集，而且本质上向这个语言添加了可选的静态类型和基于类的面向对象编程）
2. webpack+Vue全家桶（①Vue2；②Vue-router；③axios；④Vuex）+Bootstrap3的前端项目框架（附注释）
3. 前端表单验证使用了1000hz-bootstrap-validator；文件上传使用了bootstrap-fileinput；富文本编辑使用了tinyMCE；图片编辑使用了cropper；轮播图使用了Owl-Carousel 2

## 2. 使用教程（下面的命令皆以front-end-src为当前目录运行）

1. 环境搭建。安装好`node.js`后，命令行运行`npm install`
2. 启动前端程序。命令行运行`npm run dev`

# 四、运维和部署脚本（operation-and-deployment-src目录）

## 1. 架构说明

1. fabric
2. Supervisor（将`operation-and-deployment-src/supervisor/ProgrammingCases.conf`拷贝到`/etc/supervisor/conf.d/`目录下）
3. ​Nginx（配置文件请见`operation-and-deployment-src/nginx/ProgrammingCases`）

## 2. 使用教程（下面的命令皆以operation-and-deployment-src为当前目录运行）

1. `fabfile.py`为fabric部署脚本，命令行运行`fab 函数名`即可执行对应操作
2. `fab remoteBackupDB`将**服务器数据库**进行备份（仅对`_BACKUP_TABLES`中包含的表），然后把备份数据打包下载到本地
3. `fab localBackupDB`将**本地数据库**进行备份（仅对`_BACKUP_TABLES`中包含的表）
4. `fab localRestoreDB`利用数据库备份文件和`Django`的`migration`功能对**本地数据库**进行恢复
5. `fab remoteRestoreDB`利用数据库备份文件和`Django`的`migration`功能对**服务器数据库**进行恢复
6. `fab build`使用webpack将前端代码进行编译压缩，然后将前后端项目代码进行打包，用作备份或者上传服务器进行部署
7. `fab deploy`将在本地打包好的项目代码上传到服务器然后再解包
8. `fab rollback`项目代码回退到上一个版本，并重启任务
9. `fab startServer`利用Supervisor启动网站
10. `fab stopServer`利用Supervisor停止网站的运行
11. `fab checkServer`利用Supervisor查看当前网站的运行状态

# 五、补充说明

1. `github_commit.sh`是一个非常强大的脚本，只要在命令行输入`.github_commit.sh "你的注释"`即可完成代码的提交（最重要的是把所有敏感的服务器和数据库配置信息统统替换掉，然后再上传到github，上传完成后再还原回来）
