# Fabric笔记

1. 将目标文件命名为`fabfile.py`，然后在当前目录下通过命令行运行命令`fab 函数名`或者直接调用该函数即可

2. 使用`with cd(远程目录路径):`可以保证包裹在其内的`run(命令)`运行的当前目录为对应的目录

3. 使用`with lcd(本地目录路径)`：可以保证包裹在其内的`local(命令)`运行的当前目录为对应的目录

4. 上传文件：`put(local, remote, use_sudo=True)`

5. 下载文件：`get(remote, local, use_sudo=True)`
