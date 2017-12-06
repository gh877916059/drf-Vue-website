# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from fabric.api import *
import datetime
import os
import sys
import re

env.user = '服务器用户名'
env.password = "对应密码"
env.sudo_user = 'root'
env.sudo_password = "root用户密码"
env.hosts = ['服务器IP']

_TAR_FILE = 'back-end-and-front-end-src.tar.gz'
_REMOTE_TMP_DIR = '/tmp'
_REMOTE_TMP_TAR = '%s/%s' % (_REMOTE_TMP_DIR, _TAR_FILE)
_REMOTE_BASE_DIR = '/srv/APP_Inventor_case_base_website'
_CURRENT_DIR = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0, os.path.join(os.path.join(_CURRENT_DIR, 'back-end-src'), 'APP_Inventor_case_base'))
from settings import DATABASES
_DB_USER_NAME = DATABASES['default']['USER']
_DB_PASSWORD = DATABASES['default']['PASSWORD']
_DB_NAME = DATABASES['default']['NAME']

def _now():
    return datetime.now().strftime('%y-%m-%d_%H.%M.%S')

def remoteBackup():
    '''
    备份服务器端的数据库
    '''
    dt = _now()
    f = 'remote-backup-APP_Inventor_case_base_website-%s.sql' % dt
    with cd(_REMOTE_TMP_DIR):
        cmd_string = 'mysqldump --user=%s --password=%s --skip-opt --add-drop-table --default-character-set=utf8 --quick %s > %s' % (_DB_USER_NAME, _DB_PASSWORD, _DB_NAME, f)
        run(cmd_string)
        run('tar -czvf %s.tar.gz %s' % (f, f))
        get('%s.tar.gz' % f, '%s/backup/' % _CURRENT_DIR)
        run('rm -f %s' % f)
        run('rm -f %s.tar.gz' % f)

def localBackup():
    '''
    备份本地的数据库
    '''
    dt = _now()
    f = 'local-backup-APP_Inventor_case_base_website-%s.sql' % dt
    backup_dir = os.path.join(_CURRENT_DIR, 'backup')
    with lcd(backup_dir):
        cmd_string = 'mysqldump --user=%s --password=%s --skip-opt --add-drop-table --default-character-set=utf8 --quick %s > %s' % (_DB_USER_NAME, _DB_PASSWORD, _DB_NAME, f)
        local(cmd_string)

def build():
    '''
    将本地代码进行打包
    '''
    includes = ['back-end-src', 'front-end-src']
    excludes = ['*__pycache__*', '*.idea*', '*.pyc']
    local('rm -f dist/%s' % _TAR_FILE)
    with lcd(_CURRENT_DIR):
        cmd = ['tar', '--dereference', '-czvf', './dist/%s' % _TAR_FILE]
        cmd.extend(['--exclude=%s' % ex for ex in excludes])
        cmd.extend(includes)
        local(' '.join(cmd))

def deploy():
    '''
    将在本地打包好的代码上传到服务器然后再解包，然后利用supervisor启动服务，nginx进行请求转发
    '''
    newdir = 'src-%s' % _now()
    run('rm -f %s' % _REMOTE_TMP_TAR)
    with lcd(_CURRENT_DIR):
        put('./dist/%s' % _TAR_FILE, _REMOTE_TMP_TAR)
    with cd(_REMOTE_BASE_DIR):
        sudo('mkdir %s' % newdir)
    with cd('%s/%s' % (_REMOTE_BASE_DIR, newdir)):
        sudo('tar -xzvf %s' % _REMOTE_TMP_TAR)
    with cd(_REMOTE_BASE_DIR):
        sudo('rm -f src')
        sudo('ln -s %s src' % newdir)
        # sudo('chown 所有者:组 src')
        # sudo('chown -R 所有者:组 %s' % newdir)
    # 在warn_only=True包含的代码快中 如果发生了错误原本是会直接终止的，现在变为不终止了变了警告
    with settings(warn_only=True):
        sudo('supervisorctl stop APP_Inventor_case_base_website')
        sudo('supervisorctl start APP_Inventor_case_base_website')
        sudo('/etc/init.d/nginx reload')

RE_FILES = re.compile('\r?\n')

def rollback():
    '''
    代码回退到上一个版本，并重启任务
    '''
    with cd(_REMOTE_BASE_DIR):
        r = run('ls -p -1')
        files = [s[:-1] for s in RE_FILES.split(r) if s.startswith('src-') and s.endswith('/')]
        files.sort(cmp=lambda s1, s2: 1 if s1 < s2 else -1)
        r = run('ls -l src')
        ss = r.split(' -> ')
        if len(ss) != 2:
            print('错误: \'src\' 不是一个软链接')
            return
        current = ss[1]
        print('当前版本为: %s\n' % current)
        try:
            index = files.index(current)
        except ValueError as e:
            print('错误: 该软连接非法')
            return
        if len(files) == index + 1:
            print('错误: 不存在上一个版本（当前版本已经是最早备份的了）')
        old = files[index + 1]
        print('==================================================')
        for f in files:
            if f == current:
                print('    当前版本 ---> %s' % current)
            elif f == old:
                print('  准备回退到 ---> %s' % old)
            else:
                print('                   %s' % f)
        print('==================================================')
        print('')
        yn = input('是否继续? y/N ')
        if yn != 'y' and yn != 'Y':
            print('回退操作被取消')
            return
        print('开始回退...')
        sudo('rm -f src')
        sudo('ln -s %s src' % old)
        # sudo('chown 所有者:组 src')
        with settings(warn_only=True):
            sudo('supervisorctl stop awesome')
            sudo('supervisorctl start awesome')
            sudo('/etc/init.d/nginx reload')
        print('回退成功')

def _selectBackupFile():
    '''
    选择要进行还原的数据库备份文件
    '''
    backup_dir = os.path.join(_CURRENT_DIR, 'backup')
    fs = os.listdir(backup_dir)
    files = [f for f in fs if f.startswith('remote-backup-') and f.endswith('.sql.tar.gz')]
    files.extend([f for f in fs if f.startswith('local-backup-') and f.endswith('.sql.tar.gz')])
    files.sort(cmp=lambda s1, s2: 1 if s1 < s2 else -1)
    if len(files) == 0:
        print('找不到任何备份文件')
        return
    print('一共找到了%s个备份文件:' % len(files))
    print('==================================================')
    n = 0
    for f in files:
        print('%s: %s' % (n, f))
        n = n + 1
    print('==================================================')
    print('')
    try:
        num = int(input('请输入要还原的数据库备份档案: '))
    except ValueError:
        print('非法数字')
        return
    restore_file = files[num]
    yn = input('是否进行还原 %s: %s? y/N ' % (num, restore_file))
    if yn != 'y' and yn != 'Y':
        print('还原操作被取消')
        return
    print('开始进行还原操作...')
    return restore_file

def restore2local():
    '''
    将数据库备份还原到本地
    '''
    restore_file = _selectBackupFile()
    backup_dir = os.path.join(_CURRENT_DIR, 'backup')
    p = input('请输入Mysql的root用户密码: ')
    sqls = [
        'drop database if exists ' + _DB_NAME + ';',
        'create database ' + _DB_NAME + ';',
        # 'grant select, insert, update, delete on awesome.* to \'%s\'@\'localhost\' identified by \'%s\';' % (_DB_USER_NAME, _DB_PASSWORD)
    ]
    for sql in sqls:
        local(r'mysql -uroot -p%s -e "%s"' % (p, sql))
    with lcd(backup_dir):
        local('tar zxvf %s' % restore_file)
        cmd_string = 'mysql -u%s -p%s %s < backup/%s' % (_DB_USER_NAME, _DB_PASSWORD, _DB_NAME, restore_file[:-7])
        local(cmd_string)
        local('rm -f %s' % restore_file[:-7])

def restore2remote():
    '''
    将数据库备份还原到本地
    '''
    restore_file_name = _selectBackupFile()
    p = input('请输入Mysql的root用户密码: ')
    sqls = [
        'drop database if exists ' + _DB_NAME + ';',
        'create database ' + _DB_NAME + ';',
        # 'grant select, insert, update, delete on awesome.* to \'%s\'@\'localhost\' identified by \'%s\';' % (_DB_USER_NAME, _DB_PASSWORD)
    ]
    for sql in sqls:
        run(r'mysql -uroot -p%s -e "%s"' % (p, sql))
    with lcd(_CURRENT_DIR):
        put('./backup/%s' % restore_file_name, '%s/%s' % (_REMOTE_TMP_DIR, restore_file_name))
    with cd(_REMOTE_TMP_DIR):
        run('tar zxvf %s' % restore_file_name)
        cmd_string = 'mysql -u%s -p%s %s < backup/%s' % (_DB_USER_NAME, _DB_PASSWORD, _DB_NAME, restore_file_name[:-7])
        run(cmd_string)
        run('rm -f %s' % restore_file_name[:-7])