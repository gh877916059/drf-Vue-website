# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import xadmin
from .models import Questions, QuestionState

class CasesAdmin(object):
    list_display = ["name", "click_num", "fav_num",
                    "cases_brief", "cases_desc", "add_time"]
    search_fields = ['name', ]
    list_filter = ["name", "click_num", "fav_num",
                   "add_time", "category__name"]
    style_fields = {"cases_desc": "ueditor"}


class QuestionStateAdmin(object):
    list_display = ["name", "add_time"]
    list_filter = ["name"]
    search_fields = ['name']


xadmin.site.register(Questions, CasesAdmin)
xadmin.site.register(QuestionState, QuestionStateAdmin)