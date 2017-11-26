# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

# 独立使用django的model
import sys
import os

# realpath()对于软链接获取的是真实路径
pwd = os.path.dirname(os.path.realpath(__file__))
sys.path.append(pwd+"../")
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "APP_Inventor_case_base.settings")
from APP_Inventor_case_base.settings import REQUEST_HOST
import django
django.setup()

from cases.models import Cases

media_dir = os.path.join(os.path.dirname(os.path.dirname(os.path.realpath(__file__))), "media")

def clean_useless_case_cover_picture():
    main_dir = os.path.join(media_dir, "case_cover_picture")
    for user_dir in os.listdir(main_dir):
        user_name = user_dir
        user_dir = os.path.join(main_dir, user_dir)
        for image_file_name in os.listdir(user_dir):
            request_url = REQUEST_HOST + '/media/case_cover_picture/' + user_name + '/' + image_file_name
            cases = Cases.objects.filter(cases_front_image=request_url)
            if len(cases) == 0:
                os.remove(os.path.join(user_dir, image_file_name))

def clean_useless_rich_text_picture():
    from bs4 import BeautifulSoup
    request_url_to_counter = {}
    request_url_to_file_path = {}
    main_dir = os.path.join(media_dir, "rich_text_picture")
    for user_dir in os.listdir(main_dir):
        user_name = user_dir
        user_dir = os.path.join(main_dir, user_dir)
        for image_file_name in os.listdir(user_dir):
            request_url = REQUEST_HOST + '/media/rich_text_picture/' + user_name + '/' + image_file_name
            image_file_path = os.path.join(user_dir, image_file_name)
            request_url_to_file_path[request_url] = image_file_path
            request_url_to_counter[request_url] = 0
    for case in Cases.objects.all():
        cases_desc = case.cases_desc
        soup = BeautifulSoup(cases_desc)
        for img in soup.find_all('img'):
            img_src = img.get('src')
            if img_src not in request_url_to_counter:
                print("---丢失了图片文件---", img_src)
            else:
                request_url_to_counter[img_src] = request_url_to_counter[img_src] + 1
    for request_url, counter in request_url_to_counter.items():
        if(counter == 0):
            os.remove(request_url_to_file_path[request_url])


if __name__ == "__main__":
    clean_useless_case_cover_picture()
    clean_useless_rich_text_picture()