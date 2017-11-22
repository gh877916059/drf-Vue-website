# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import django_filters
from django.db.models import Q

from .models import Cases


class CasesFilter(django_filters.rest_framework.FilterSet):
    """
    案例的过滤类
    """
    top_category = django_filters.NumberFilter(method='top_category_filter')


    def top_category_filter(self, queryset, name, value):
        return queryset.filter(Q(category_id=value)|Q(category__parent_category_id=value)|Q(category__parent_category__parent_category_id=value))


    class Meta:
        model = Cases
        fields = []