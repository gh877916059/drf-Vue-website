# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework import serializers
from django.db.models import Q
from cases.models import Cases, CasesCategory, HotSearchWords, Banner
from users.serializers import UserDetailSerializer

class CategorySerializer2(serializers.ModelSerializer):
    class Meta:
        model = CasesCategory
        fields = ("id", "name", "parent_category")


class CategorySerializer(serializers.ModelSerializer):
    sub_cat = CategorySerializer2(many=True)
    class Meta:
        model = CasesCategory
        fields = ("id", "name", "sub_cat")

class GetCasesSerializer(serializers.ModelSerializer):
    category = CategorySerializer()
    submitter = UserDetailSerializer()
    class Meta:
        model = Cases
        fields = "__all__"

class PostCasesSerializer(serializers.ModelSerializer):
    category_id = serializers.IntegerField(required=True, write_only=True, label="类别ID", help_text="类别ID")

    '''
    def validate(self, attrs):
        category_id = attrs['category_id']
        category = CasesCategory.objects.get(Q(id=category_id))
        attrs['category'] = category
        del attrs["category_id"]
        return attrs
    '''

    def pre_save(self, attrs):
        attrs.submitter = self.request.user
        print('---attrs.submitter---')
        print(attrs.submitter)
        attrs.category = CasesCategory.objects.filter(id=category_id)

    class Meta:
        model = Cases
        fields = ("category_id", "name", "cases_brief", "cases_desc", "cases_front_image")


class HotWordsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotSearchWords
        fields = "__all__"


class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Banner
        fields = "__all__"