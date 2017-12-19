import os
import shutil
BACK_END_BASE_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'back-end-src')

def deleteAllMigrationFiles():
    app_parent_dir_list = []
    app_parent_dir_list.append(os.path.join(BACK_END_BASE_DIR, 'apps'))
    app_parent_dir_list.append(os.path.join(BACK_END_BASE_DIR, 'extra_apps'))
    for app_parent_dir in app_parent_dir_list:
        for app_name in os.listdir(app_parent_dir):
            app_dir = os.path.join(app_parent_dir, app_name)
            migration_dir = os.path.join(app_dir, 'migrations')
            if os.path.exists(migration_dir):
                for migration_file_name in os.listdir(migration_dir):
                    if migration_file_name != '__init__.py':
                        migration_file_path = os.path.join(migration_dir, migration_file_name)
                        if os.path.isfile(migration_file_path):
                            os.remove(migration_file_path)
                        elif os.path.isdir(migration_file_path) and migration_file_name == '__pycache__':
                            shutil.rmtree(migration_file_path)

if __name__ == "__main__":
    deleteAllMigrationFiles()