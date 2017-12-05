import pymysql
import os
import sys
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(BASE_DIR, 'APP_Inventor_case_base'))
from settings import DATABASES
default_conf = DATABASES['default']

connect = pymysql.connect(
    user=default_conf['USER'],
    password=default_conf['PASSWORD'],
    host=default_conf['HOST'],
    db=default_conf['NAME'],
    charset="utf8",
    port=3306
)

conn = connect.cursor()  # 创建游标以便来操作数据库

cmdString = 'D:/php/phpStudy/MySQL/bin/mysqldump -u root --password=root --database  abcDataBase >  c:/abc_backup.sql'
os.system(cmdString)