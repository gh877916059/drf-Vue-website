# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework import serializers
from django.db.models import Q
from cases.models import Cases, CasesCategory, HotSearchWords, CasesImage, Banner


class CategorySerializer2(serializers.ModelSerializer):
    class Meta:
        model = CasesCategory
        fields = "__all__"


class CategorySerializer(serializers.ModelSerializer):
    sub_cat = CategorySerializer2(many=True)
    class Meta:
        model = CasesCategory
        fields = "__all__"


class CasesImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = CasesImage
        fields = ("image", )

class CasesSerializer(serializers.ModelSerializer):
    category = CategorySerializer()
    #images = CasesImageSerializer(many=True)
    class Meta:
        model = Cases
        fields = "__all__"
        #fields = ("category", "name", "cases_brief", "cases_desc", "cases_front_image")


class HotWordsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotSearchWords
        fields = "__all__"


class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Banner
        fields = "__all__"