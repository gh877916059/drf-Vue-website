# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

from .models import UserFav
from cases.serializers import GetCasesSerializer


class UserFavDetailSerializer(serializers.ModelSerializer):
    cases = GetCasesSerializer()

    class Meta:
        model = UserFav
        fields = ("goods", "id")


class UserFavSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        model = UserFav
        validators = [
            UniqueTogetherValidator(
                queryset=UserFav.objects.all(),
                fields=('user', 'goods'),
                message="已经收藏"
            )
        ]

        fields = ("user", "goods", "id")