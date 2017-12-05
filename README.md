# 里程碑

1. 完成后端Xadmin+Django全家桶（①django；②django-REST-framework；③django-filter；④django-simple-captcha；⑤django-REST-framework-jwt ）项目框架（附注释）
2. 完成前端webpack+Vue全家桶（①Vue2；②Vue-router；③Vue-resource；④Vuex）的前端项目框架（附注释）
3. 利用BootStrap3完成了顶部导航栏、注册、登录、案例发布的页面设计
4. 利用Django REST framework完成了注册、登录、案例发布的后台业务逻辑代码的编写
5. 完成案例列表页和案例详情页的页面设计和逻辑代码的编写

# 使用说明

1. 后台环境搭建。安装好Python3.5或者Python3.6，在本项目根目录打开命令行，并输入：`pip install -r python-lib-requirements.txt`

2. 前端环境搭建。安装好node.js，进入/Front-End-Vue-Project目录，打开命令行并输入：`npm install`

3. 数据库生成。修改/APP_Inventor_case_base/settings.py中的DATABASES为你自己的Mysql数据库配置，依次运行`python manage.py makemigrations`和`python manage.py migrate`

4. 启动后台程序，运行`python manage.py runserver`

5. 启动前端程序，进入进入/Front-End-Vue-Project目录，运行`npm run dev`

6. 后台工具脚本说明：①/db_tools/clean_useless_files.py用于删除/media下已经失效的用户上传图片文件（完全没有被当前任何数据引用到的）；
②/db_tools/import_category_data.py用于往数据表中插入案例的类别数据，用于初始化数据库；
③/db_tools/init_migrations.py用于删除所有的migration文件，然后重新进行`makemigrations`操作；
④/db_tools/backup.py用于备份数据库；
⑤/db_tools/restore.py用于利用备份数据进行数据库还原