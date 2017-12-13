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
from .models import Cases, CasesCategory, HotSearchWords, Banner
from .filters import CasesFilter
from .serializers import GetCasesSerializer, PostCasesSerializer, CategorySerializer, HotWordsSerializer, BannerSerializer
from rest_framework import status
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.permissions import IsAuthenticatedOrReadOnly
# Create your views here.


class CasesPagination(PageNumberPagination):
    page_size = 12
    page_size_query_param = 'page_size'
    page_query_param = "page"
    max_page_size = 100


class CasesListViewSet(mixins.CreateModelMixin, mixins.ListModelMixin, mixins.RetrieveModelMixin, mixins.UpdateModelMixin, mixins.DestroyModelMixin, viewsets.GenericViewSet):
    """
    案例列表页, 分页， 搜索， 过滤， 排序
    """
    throttle_classes = (UserRateThrottle, )
    queryset = Cases.objects.all()
    serializer_class = GetCasesSerializer
    pagination_class = CasesPagination
    authentication_classes = (JSONWebTokenAuthentication, )
    permission_classes = (IsAuthenticatedOrReadOnly,)
    filter_backends = (DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter)
    filter_class = CasesFilter
    search_fields = ('name', 'cases_brief', 'cases_desc')
    ordering_fields = ('click_num', 'add_time')

    def get_serializer_class(self):
        if self.action == "retrieve":
            return GetCasesSerializer
        # 当进行的是创建新案例时
        elif self.action == "create":
            return PostCasesSerializer
        elif self.action == "update":
            return PostCasesSerializer
        return GetCasesSerializer

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

class CategoryViewset(mixins.ListModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    """
    list:
        案例分类列表数据
    retrieve:
        获取案例分类详情
    """
    queryset = CasesCategory.objects.filter(category_type=1)
    serializer_class = CategorySerializer


class HotSearchsViewset(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    获取热搜词列表
    """
    queryset = HotSearchWords.objects.all().order_by("-index")
    serializer_class = HotWordsSerializer


class BannerViewset(mixins.ListModelMixin, viewsets.GenericViewSet):
    """
    获取案例轮播图列表
    """
    queryset = Banner.objects.all().order_by("index")
    serializer_class = BannerSerializer