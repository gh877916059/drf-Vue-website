# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

# Create your views here.
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model
from django.db.models import Q
from rest_framework.mixins import CreateModelMixin
from rest_framework import mixins
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from random import choice
from rest_framework import permissions
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.throttling import UserRateThrottle, AnonRateThrottle
from rest_framework_jwt.serializers import jwt_encode_handler, jwt_payload_handler
from .serializers import SmsSerializer, UserRegSerializer, UserDetailSerializer
from APP_Inventor_case_base.settings import APIKEY
from utils.yunpian import YunPian
from .models import SmsVerifyCode
from rest_framework.views import APIView
from captcha.models import CaptchaStore
from captcha.helpers import captcha_image_url

'''
在setting.py文件中指定AUTHENTICATION_BACKENDS为CustomBackend，即可生效
以下写法模仿django.contrib.auth.backends.ModelBackend
由于验证只需要用到用户名和密码，因此参数中并不存在request
Q对象可以对关键字参数进行封装，从而更好地应用多个查询。可以组合使用 &（and）,|（or），~（not）操作符，当一个操作符是用于两个Q的对象,它产生一个新的Q对象
'''
User = get_user_model()     # 得到的是setting.py中定义的AUTH_USER_MODEL配置项，即users.UserProfile
class CustomBackend(ModelBackend):
    def authenticate(self, username=None, password=None, **kwargs):
        try:
            user = User.objects.get(Q(username=username)|Q(mobile=username))
            if user.check_password(password):
                return user
        except Exception as e:
            return None

class PictureCodeView(APIView):
    """
    图片验证码
    """
    throttle_classes = (UserRateThrottle, AnonRateThrottle)

    def get(self, request, format=None):
        response_data = dict()
        response_data['cptch_key'] = CaptchaStore.generate_key()
        response_data['cptch_image'] = captcha_image_url(response_data['cptch_key'])
        return Response(response_data, status=status.HTTP_200_OK, content_type='application/json')

class SmsCodeViewset(CreateModelMixin, viewsets.GenericViewSet):
    """
    发送短信验证码
    """
    serializer_class = SmsSerializer

    def generate_code(self):
        """
        生成四位数字的验证码
        :return:
        """
        seeds = "1234567890"
        random_str = []
        for i in range(4):
            random_str.append(choice(seeds))

        return "".join(random_str)

    def create(self, request, *args, **kwargs):
        print(request.data)
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        mobile = serializer.validated_data["mobile"]

        yun_pian = YunPian(APIKEY)

        code = self.generate_code()

        sms_status = yun_pian.send_sms(code=code, mobile=mobile)

        if sms_status["code"] != 0:
            return Response({
                "mobile":sms_status["msg"]
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            code_record = SmsVerifyCode(code=code, mobile=mobile)
            code_record.save()
            return Response({
                "mobile":mobile
            }, status=status.HTTP_201_CREATED)

class UserViewset(CreateModelMixin, mixins.UpdateModelMixin, mixins.RetrieveModelMixin, viewsets.GenericViewSet):
    """
    用户
    """
    serializer_class = UserRegSerializer    # 序列化类
    queryset = User.objects.all()       # 这里只是定义了SQL语句的写法，并不会真的进行查询，只有当遍历对应数据时才会进行真正的查询
    authentication_classes = (JSONWebTokenAuthentication, )    # 访问该视图需要验证身份信息，将使用这些类

    def get_serializer_class(self):
        if self.action == "retrieve":
            return UserDetailSerializer
        # 当进行的是注册新用户时
        elif self.action == "create":
            return UserRegSerializer

        return UserDetailSerializer

    # permission_classes = (permissions.IsAuthenticated, )
    def get_permissions(self):
        if self.action == "retrieve":
            return [permissions.IsAuthenticated()]
        elif self.action == "create":
            return []

        return []

    def retrieve(self, request, *args, **kwargs):
        print("---request.data---")
        print(request.data)
        print("----request.user---")
        print(request.user)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = self.perform_create(serializer)      # 注册成功，将SQL记录插入语句提交到数据库执行

        re_dict = serializer.data

        # JWT模块的加密算法得到token，降低服务器的存储压力，并提高安全性
        payload = jwt_payload_handler(user)
        re_dict["jwt_token"] = jwt_encode_handler(payload)

        headers = self.get_success_headers(serializer.data)
        return Response(re_dict, status=status.HTTP_201_CREATED, headers=headers)

    def get_object(self):
        return self.request.user

    def perform_create(self, serializer):
        return serializer.save()


