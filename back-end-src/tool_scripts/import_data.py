# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

# 独立使用django的model
import sys
import os

# realpath()对于软链接获取的是真实路径
BASE_PATH = os.path.dirname(os.path.dirname(os.path.realpath(__file__)))
sys.path.append(BASE_PATH)
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "APP_Inventor_case_base.settings")

import django
django.setup()

def import_category_data():
    from cases.models import CasesCategory
    from tool_scripts.data.wait_to_import.category_data import row_data
    for lev1_cat in row_data:
        lev1_intance = CasesCategory()
        lev1_intance.code = lev1_cat["code"]
        lev1_intance.name = lev1_cat["name"]
        lev1_intance.category_type = 1
        lev1_intance.save()

        for lev2_cat in lev1_cat["sub_categorys"]:
            lev2_intance = CasesCategory()
            lev2_intance.code = lev2_cat["code"]
            try:
                lev2_intance.name = lev2_cat["name"]
            except KeyError as err:
                print(lev2_cat)
            lev2_intance.category_type = 2
            lev2_intance.parent_category = lev1_intance
            lev2_intance.save()

if __name__ == "__main__":
    import_category_data()