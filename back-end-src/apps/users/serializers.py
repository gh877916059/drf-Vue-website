# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import re
from rest_framework import serializers
from django.contrib.auth import get_user_model
from datetime import datetime
from datetime import timedelta
from rest_framework.validators import UniqueValidator
from captcha.models import CaptchaStore
from django.utils import timezone

User = get_user_model()

class UserDetailSerializer(serializers.ModelSerializer):
    """
    用户详情序列化类
    """
    class Meta:
        model = User
        fields = ("username", "gender")

# Serializer类的所有属性和方法都被作为检验条件，必须全部都符合要求
class UserRegSerializer(serializers.ModelSerializer):
    code = serializers.CharField(required=True, write_only=True, max_length=4, min_length=4, label="验证码",
                                 error_messages={
                                     "blank": "请输入验证码",
                                     "required": "请输入验证码",
                                     "max_length": "验证码格式错误",
                                     "min_length": "验证码格式错误"
                                 },
                                 help_text="验证码")
    picture_token = serializers.CharField(required=True, write_only=True, max_length=40, min_length=40, label="验证码令牌",
                                 error_messages={
                                     "blank": "请传输验证码令牌",
                                     "required": "请传输验证码令牌",
                                     "max_length": "验证码令牌格式错误",
                                     "min_length": "验证码令牌格式错误"
                                 },
                                 help_text="验证码令牌")
    # 除了一般的格式检查外，用户名还需要查询全库是否存在重复
    username = serializers.CharField(label="用户名", help_text="用户名", required=True, allow_blank=False,
                                     validators=[UniqueValidator(queryset=User.objects.all(), message="用户已经存在")])

    password = serializers.CharField(
        style={'input_type': 'password'},help_text="密码", label="密码", write_only=True,
    )

    def validate(self, attrs):
        code = attrs["code"]
        picture_token = attrs["picture_token"]
        try:
            verify_record = CaptchaStore.objects.get(hashkey=picture_token)
            if verify_record:
                expiration = verify_record.expiration
                response = verify_record.response
                verify_record.delete()
                if timezone.now() > expiration:
                    raise serializers.ValidationError("验证码过期")
                if response != code.lower():
                    raise serializers.ValidationError("验证码错误")
            else:
                raise serializers.ValidationError("验证码令牌错误")
        except CaptchaStore.DoesNotExist:
            raise serializers.ValidationError("验证码令牌错误")

        # 数据检查结束，这些属性是不写入到数据表的，必须删掉
        del attrs["code"]
        del attrs["picture_token"]
        return attrs

    class Meta:
        model = User
        fields = ("username", "code", "mobile", "password", "picture_token")     # 返回attrs中的这些值作为最终序列化的结果