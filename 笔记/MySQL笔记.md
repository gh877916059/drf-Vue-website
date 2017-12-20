# MySQL笔记

1. DDL：Data Definition Language，数据定义语言，包括：`CREATE`、`ALTER`、`DROP`、`TRUNCATE`、`COMMENT`、`GRANT`、`REVOKE`
2. DML：Data Manipulation Language，数据操作语言，包括：`SELECT`、`INSERT`、`UPDATE`、`DELETE`、`CALL`、`EXPLAIN PLAN`、`LOCK TABLE`
3. DCL：Data Control Language，数据控制语言，包括：`COMMIT`、`SAVEPOINT`、`ROLLBACK`、`SET TRANSACTION`


## 1. 数据库初始化

### 1.
```
vi /etc/my.cnf
```
在`[mysqld]`的段中加上一句：`skip-grant-tables`
### 2.
```
/etc/init.d/mysqld restart
```
### 3.
```
mysql
USE mysql;
UPDATE user SET Password = password ( 'new-password' ) WHERE User = 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '87319106' WITH GRANT OPTION;
flush privileges;
quit
```
### 4.
```
vi /etc/my.cnf
```
将刚才在`[mysqld]`的段中加上的`skip-grant-tables`删除 

### 5.
```
/etc/init.d/mysqld restart
```

## 2. 数据库备份与恢复

### 备份
```
mysqldump -u用户名 -p密码 数据库名>备份文件具体路径
```

有3种方式来调用mysqldump：
```
mysqldump [options] db_name [tables]
```
```
mysqldump [options] ---database DB1 [DB2 DB3...]
```
```
mysqldump [options] --all--database
```

参数`--opt`：等同于`--add-drop-table, --add-locks, --create-options,   --quick, --extended-insert, --lock-tables, --set-charset, and --disable-keys`

参数`--skip-opt`：等同于`Disable --opt`

`-d`选项用于指定只导出表的创建语句

`-t`选项用于指定不增加create table建表和drop table语句

`-f`选项，即force，用于忽略错误，强制继续运行

`-c`是在insert中增加具体的字段名，默认是不带字段名的

`-w`后边跟where条件，只导出符合条件的数据

### 恢复
```
mysql -u用户名 -p密码 数据库名<备份文件具体路径
```

## 3. 修改密码

```
mysql> set password for 用户名@localhost = password('新密码'); 
```

## 4. 新建数据库

字符集：`utf8 -- UTF-8 Unicode`
排序规则：`utf8_general_ci`

## 5. 启动MYSQL

```
mysqld_safe
```
或者
```
mysqld
```