# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework import serializers
from django.db.models import Q
from cases.models import Cases, CasesCategory, HotSearchWords, CasesImage, Banner


class CategorySerializer2(serializers.ModelSerializer):
    class Meta:
        model = CasesCategory
        # fields = "__all__"
        fields = ("id", "name", "parent_category")


class CategorySerializer(serializers.ModelSerializer):
    sub_cat = CategorySerializer2(many=True)
    class Meta:
        model = CasesCategory
        #fields = "__all__"
        fields = ("id", "name", "sub_cat")


class CasesImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = CasesImage
        fields = ("image", )

class GetCasesSerializer(serializers.ModelSerializer):
    category = CategorySerializer()
    #images = CasesImageSerializer(many=True)

    class Meta:
        model = Cases
        fields = "__all__"

class PostCasesSerializer(serializers.ModelSerializer):
    #category = CategorySerializer()
    #images = CasesImageSerializer(many=True)
    category_id = serializers.IntegerField(required=True, write_only=True, label="类别ID", help_text="类别ID")

    def validate(self, attrs):
        category_id = attrs['category_id']
        category = CasesCategory.objects.get(Q(id=category_id))
        attrs['category'] = category
        del attrs["category_id"]
        return attrs

    class Meta:
        model = Cases
        #fields = "__all__"
        fields = ("category_id", "name", "cases_brief", "cases_desc", "cases_front_image")


class HotWordsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotSearchWords
        fields = "__all__"


class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Banner
        fields = "__all__"