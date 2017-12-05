import os
import shutil
import sys
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def deleteAllMigrationFiles():
    app_parent_dir_list = []
    app_parent_dir_list.append(os.path.join(BASE_DIR, 'apps'))
    app_parent_dir_list.append(os.path.join(BASE_DIR, 'extra_apps'))
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

def makeMigration():
    os.chdir(BASE_DIR)
    print('---os.getcwd()---')
    print(os.getcwd())
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "APP_Inventor_case_base.settings")
    try:
        from django.core.management import execute_from_command_line
    except ImportError:
        # The above import may fail for some other reason. Ensure that the
        # issue is really that Django is missing to avoid masking other
        # exceptions on Python 2.
        try:
            import django
        except ImportError:
            raise ImportError(
                "Couldn't import Django. Are you sure it's installed and "
                "available on your PYTHONPATH environment variable? Did you "
                "forget to activate a virtual environment?"
            )
        raise
    execute_from_command_line('makemigrations')

if __name__ == "__main__":
    deleteAllMigrationFiles()
    makeMigration()