# Linux命令笔记

1. vim编码：`set encoding=utf-8`
2. 格式化字符串：`%[flags][width][.prec][F|N|h|l]type`
3. 上传文件：`rz -bye`
4. 下载文件：`sz 文件名`
5. 压缩：
1.`tar -cvf log.tar log`仅打包，不压缩
2.`tar -zcvf log.tar.gz log`打包后，以`gzip`压缩
3.`tar -jcvf log.tar.bz2 log`打包后，以`bzip2`压缩 
6. 解压：
1.`tar -xvf log.tar`
2.`tar -zxvf log.tar.gz`
3.`tar -jxvf log.tar.bz2`
4.对于`***.tar.xz`文件，可以先运行`xz -d ***.tar.xz`，然后再运行`tar -xvf ***.tar`
7. 编译DLL文件
```
./configure --enable-shared --prefix=/home/luweirong/Downloads --disable-avcodec
`make & sudo make install
```
8. 环境变量
`/etc/profile`、`/etc/bashrc`是系统全局环境变量设定
`~/.profile`，`~/.bashrc`是用户家目录下的私有环境变量设定
9. 删除目录：`rm -rf 目录路径或名称`
10. 新建目录：`mkdir 目录路径`
11. 重命名文件：`mv 旧文件名 新文件名`
12. 目录整体移动：`mv 子目录 父目录`
13. 查看那个进程占用了xxx端口
`lsof -i:xxx`或者`netstat –apn|grep xxx`
得到进程号yyy后，继续进行查询
`ps -ef|grep yyy`
14. 重启：`reboot`
15. 查看Linux系统版本信息：``
16. 修改自己的密码：`passwd`
17. 修改他人的密码：`passwd xxx`
18. 查看文件详细信息：
```
$ ls -l sobsrc. tgz
-rw-r--r-- 1 root root 483997 Ju1 l5 17:3l sobsrc. tgz
```
第一个字符代表文件类型，2-4代表所属用户权限（分别为读、写、可执行），5-7代表所属用户组权限，8-10代表其他用户权限
19. 添加用户：`adduser 用户名`；添加工作组：`groupadd 工作组名`；删除用户：`userdel 用户名`
20. 更改文件所有者：`chown [-R] 账号名称 文件或目录`，其中`-R`表示进行递归
21. 添加执行权限：`chmod a+x 文件`
22. 后台启动程序：`nohup 你要执行的命令 &`