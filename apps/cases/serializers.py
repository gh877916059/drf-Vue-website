# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework import serializers
from django.db.models import Q

from cases.models import Cases, CasesCategory, HotSearchWords, CasesImage, Banner
from cases.models import CasesCategoryBrand, IndexAd

class CategorySerializer3(serializers.ModelSerializer):
    class Meta:
        model = CasesCategory
        fields = "__all__"


class CategorySerializer2(serializers.ModelSerializer):
    sub_cat = CategorySerializer3(many=True)
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
    images = CasesImageSerializer(many=True)
    class Meta:
        model = Cases
        fields = "__all__"


class HotWordsSerializer(serializers.ModelSerializer):
    class Meta:
        model = HotSearchWords
        fields = "__all__"


class BannerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Banner
        fields = "__all__"


class BrandSerializer(serializers.ModelSerializer):
    class Meta:
        model = CasesCategoryBrand
        fields = "__all__"


class IndexCategorySerializer(serializers.ModelSerializer):
    brands = BrandSerializer(many=True)
    cases = serializers.SerializerMethodField()
    sub_cat = CategorySerializer2(many=True)
    ad_cases = serializers.SerializerMethodField()

    def get_ad_cases(self, obj):
        cases_json = {}
        ad_cases = IndexAd.objects.filter(category_id=obj.id, )
        if ad_cases:
            case_ins = ad_cases[0].cases
            cases_json = CasesSerializer(case_ins, many=False, context={'request': self.context['request']}).data
        return cases_json



    def get_cases(self, obj):
        all_cases = Cases.objects.filter(Q(category_id=obj.id)|Q(category__parent_category_id=obj.id)|Q(category__parent_category__parent_category_id=obj.id))
        cases_serializer = CasesSerializer(all_cases, many=True, context={'request': self.context['request']})
        return cases_serializer.data

    class Meta:
        model = CasesCategory
        fields = "__all__"
