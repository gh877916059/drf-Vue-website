# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from django.conf.urls import url, include
# from django.contrib import admin
import xadmin
from APP_Inventor_case_base.settings import MEDIA_ROOT
from django.views.static import serve
from rest_framework.documentation import include_docs_urls
from rest_framework.routers import DefaultRouter
from rest_framework.authtoken import views
from rest_framework_jwt.views import obtain_jwt_token
from users.views import SmsCodeViewset, UserViewset

# 利用了ViewSet的重载as_view()方法进行请求方法和处理函数的动态绑定（简单好用，只需要逐一register，然后urls函数即可）
router = DefaultRouter()

router.register(r'codes', SmsCodeViewset, base_name="codes")

router.register(r'users', UserViewset, base_name="users")

#留言
router.register(r'messages', LeavingMessageViewset, base_name="messages")

#收货地址
router.register(r'address', AddressViewset, base_name="address")

#购物车url
router.register(r'shopcarts', ShoppingCartViewset, base_name="shopcarts")

#订单相关url
router.register(r'orders', OrderViewset, base_name="orders")

#轮播图url
router.register(r'banners', BannerViewset, base_name="banners")

#首页商品系列数据
router.register(r'indexgoods', IndexCategoryViewset, base_name="indexgoods")

'''
goods_list = GoodsListViewSet.as_view({
    'get': 'list',
})
'''

from trade.views import AlipayView
from django.views.generic import TemplateView
urlpatterns = [
    url(r'^xadmin/', xadmin.site.urls),
    url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework')),

    # path 将作为第二参数传到server进行处理
    url(r'^media/(?P<path>.*)$', serve, {"document_root": MEDIA_ROOT}),

    url(r'^', include(router.urls)),

    url(r'^index/', TemplateView.as_view(template_name="index.html"), name="index"),

    url(r'docs/', include_docs_urls(title="生鲜电商")),

    # drf自带的token认证模式
    url(r'^api-token-auth/', views.obtain_auth_token),

    # jwt的认证接口
    url(r'^login/', obtain_jwt_token),

    url(r'^alipay/return/', AlipayView.as_view(), name="alipay"),
]