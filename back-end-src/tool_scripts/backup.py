import os
import sys

if __name__ == "__main__":
    BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    sys.path.insert(0, os.path.join(BASE_DIR, 'APP_Inventor_case_base'))
    from settings import DATABASES

    default_conf = DATABASES['default']

    db_backup_file_dir = os.path.dirname(os.path.abspath(__file__))
    db_backup_file_dir = os.path.join(db_backup_file_dir, 'data')
    db_backup_file_dir = os.path.join(db_backup_file_dir, 'db_backup')
    version_counter = 0
    for db_backup_file_name in os.listdir(db_backup_file_dir):
        if not db_backup_file_name.endswith('.sql'):
            print('---存在非法文件---')
            print(db_backup_file_name)
            exit()
        version = int(db_backup_file_name[:-4])
        if version > version_counter:
            version_counter = version
    version_counter = version_counter + 1
    db_backup_file_path = os.path.join(db_backup_file_dir, str(version_counter) + '.sql')
    mysqldump_procedure_path = '"C:/MySoftware/MySQL Server 5.7/bin/mysqldump"'
    user_name = default_conf['USER']
    password = default_conf['PASSWORD']
    db_name = default_conf['NAME']
    cmdString = mysqldump_procedure_path + ' -u' + user_name + ' -p' + password + ' ' + db_name + '>' + db_backup_file_path
    print(cmdString)
    os.system(cmdString)