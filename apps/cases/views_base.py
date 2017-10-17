# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from django.views.generic.base import View

from cases.models import Cases
# from django.views.generic import ListView


class CasesListView(View):
    def get(self, request):
        """
        通过django的view实现案例列表页
        :param request:
        :return:
        """
        json_list = []
        cases = Cases.objects.all()[:10]
        # for case in cases:
        #     json_dict = {}
        #     json_dict["name"] = case.name
        #     json_dict["category"] = case.category.name
        #     json_dict["market_price"] = case.market_price
        #     json_dict["add_time"] = case.add_time
        #     json_list.append(json_dict)

        # from django.forms.models import model_to_dict
        # for case in cases:
        #     json_dict = model_to_dict(case)
        #     json_list.append(json_dict)

        import json
        from django.core import serializers
        json_data = serializers.serialize('json', cases)
        json_data = json.loads(json_data)
        from django.http import HttpResponse, JsonResponse
        return JsonResponse(json_data, safe=False)



