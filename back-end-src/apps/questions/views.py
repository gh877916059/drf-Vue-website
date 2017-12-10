# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework.response import Response
from rest_framework import mixins
from rest_framework import filters
from rest_framework.pagination import PageNumberPagination
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework import viewsets
from rest_framework.throttling import UserRateThrottle
from rest_framework_extensions.cache.mixins import CacheResponseMixin
from .models import Questions
from .filters import CasesFilter
from .serializers import GetQuestionsSerializer, PostQuestionsSerializer
from rest_framework import status
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.permissions import IsAuthenticatedOrReadOnly
# Create your views here.


class QuestionsPagination(PageNumberPagination):
    page_size = 12
    page_size_query_param = 'page_size'
    page_query_param = "page"
    max_page_size = 100


class QuestionsListViewSet(mixins.CreateModelMixin, mixins.ListModelMixin, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin, viewsets.GenericViewSet):
    """
    问题列表页, 分页， 搜索， 过滤， 排序
    """
    throttle_classes = (UserRateThrottle, )
    queryset = Questions.objects.all()
    serializer_class = GetQuestionsSerializer
    pagination_class = QuestionsPagination
    authentication_classes = (JSONWebTokenAuthentication, )
    permission_classes = (IsAuthenticatedOrReadOnly,)
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = CasesFilter
    search_fields = ('name', 'cases_brief', 'cases_desc')
    ordering_fields = ('click_num', 'add_time')

    def get_serializer_class(self):
        if self.action == "retrieve":
            return GetQuestionsSerializer
        # 当进行的是注册新用户时
        elif self.action == "create":
            return PostQuestionsSerializer
        elif self.action == "update":
            return PostQuestionsSerializer
        return GetQuestionsSerializer

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        instance.click_num += 1
        instance.save()
        serializer = self.get_serializer(instance)
        return Response(serializer.data)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        print("---serializer---")
        print(serializer)
        case = serializer.save()      # 注册成功，将SQL记录插入语句提交到数据库执行
        re_dict = serializer.data
        re_dict['id'] = case.id
        headers = self.get_success_headers(serializer.data)
        return Response(re_dict, status=status.HTTP_201_CREATED, headers=headers)