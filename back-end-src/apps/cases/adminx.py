# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import xadmin
from .models import Cases, CasesCategory, CasesImage, Banner, HotSearchWords

class CasesAdmin(object):
    list_display = ["name", "click_num", "fav_num",
                    "cases_brief", "cases_desc", "add_time"]
    search_fields = ['name', ]
    list_filter = ["name", "click_num", "fav_num",
                   "add_time", "category__name"]
    style_fields = {"cases_desc": "ueditor"}

    class CasesImagesInline(object):
        model = CasesImage
        exclude = ["add_time"]
        extra = 1
        style = 'tab'

    inlines = [CasesImagesInline]


class CasesCategoryAdmin(object):
    list_display = ["name", "category_type", "parent_category", "add_time"]
    list_filter = ["category_type", "parent_category", "name"]
    search_fields = ['name', ]


class BannerCasesAdmin(object):
    list_display = ["title", "hyperlink", "image", "index"]


class HotSearchAdmin(object):
    list_display = ["keywords", "index", "add_time"]


xadmin.site.register(Cases, CasesAdmin)
xadmin.site.register(CasesCategory, CasesCategoryAdmin)
xadmin.site.register(Banner, BannerCasesAdmin)
xadmin.site.register(HotSearchWords, HotSearchAdmin)