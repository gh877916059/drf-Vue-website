# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from datetime import datetime

from django.db import models
from django.contrib.auth import get_user_model

from cases.models import Cases
# Create your models here.
User = get_user_model()


class UserFav(models.Model):
    """
    用户收藏
    """
    user = models.ForeignKey(User, verbose_name="用户")
    goods = models.ForeignKey(Cases, verbose_name="案例", help_text="案例id")
    add_time = models.DateTimeField(default=datetime.now, verbose_name=u"添加时间")

    class Meta:
        verbose_name = '用户收藏'
        verbose_name_plural = verbose_name
        unique_together = ("user", "goods")

    def __str__(self):
        return self.user.username