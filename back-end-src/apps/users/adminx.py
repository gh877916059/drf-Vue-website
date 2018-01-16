# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import xadmin
from xadmin import views


class BaseSetting(object):
    enable_themes = True
    use_bootswatch = True


class GlobalSettings(object):
    site_title = "App Inventor案例库后台"
    site_footer = "App Inventor cases"


xadmin.site.register(views.BaseAdminView, BaseSetting)
xadmin.site.register(views.CommAdminView, GlobalSettings)