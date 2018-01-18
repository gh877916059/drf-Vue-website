# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "APP_Inventor_case_base.settings")

application = get_wsgi_application()
