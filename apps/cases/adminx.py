# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import xadmin
from .models import Cases, CasesCategory, CasesImage, Banner, HotSearchWords
from .models import IndexAd

class CasesAdmin(object):
    list_display = ["name", "click_num", "sold_num", "fav_num", "cases_num", "market_price",
                    "shop_price", "cases_brief", "cases_desc", "is_new", "is_hot", "add_time"]
    search_fields = ['name', ]
    list_editable = ["is_hot", ]
    list_filter = ["name", "click_num", "sold_num", "fav_num", "cases_num", "market_price",
                   "shop_price", "is_new", "is_hot", "add_time", "category__name"]
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


class CasesBrandAdmin(object):
    list_display = ["category", "image", "name", "desc"]

    def get_context(self):
        context = super(CasesBrandAdmin, self).get_context()
        if 'form' in context:
            context['form'].fields['category'].queryset = CasesCategory.objects.filter(category_type=1)
        return context


class BannerCasesAdmin(object):
    list_display = ["cases", "image", "index"]


class HotSearchAdmin(object):
    list_display = ["keywords", "index", "add_time"]


class IndexAdAdmin(object):
    list_display = ["category", "cases"]


xadmin.site.register(Cases, CasesAdmin)
xadmin.site.register(CasesCategory, CasesCategoryAdmin)
xadmin.site.register(Banner, BannerCasesAdmin)

xadmin.site.register(HotSearchWords, HotSearchAdmin)
xadmin.site.register(IndexAd, IndexAdAdmin)

