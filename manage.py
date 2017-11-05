# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import os
import sys

# 常用参数：makemigrations、migrate、runserver
if __name__ == "__main__":
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
    execute_from_command_line(sys.argv)
