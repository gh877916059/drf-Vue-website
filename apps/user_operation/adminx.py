# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import xadmin
from .models import UserFav

class UserFavAdmin(object):
    list_display = ['user', 'goods', "add_time"]

xadmin.site.register(UserFav, UserFavAdmin)