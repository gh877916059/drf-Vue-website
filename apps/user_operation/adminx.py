# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import xadmin
from .models import UserFav, UserLeavingMessage

class UserFavAdmin(object):
    list_display = ['user', 'goods', "add_time"]

class UserLeavingMessageAdmin(object):
    list_display = ['user', 'message_type', "message", "add_time"]

xadmin.site.register(UserFav, UserFavAdmin)
xadmin.site.register(UserLeavingMessage, UserLeavingMessageAdmin)