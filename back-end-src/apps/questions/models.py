# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from datetime import datetime
from django.db import models

class QuestionState(models.Model):
    """
    问题状态
    """
    name = models.CharField(default="", max_length=30, verbose_name="类别名", help_text="类别名")
    code = models.CharField(default="", max_length=30, verbose_name="类别code", help_text="类别code")
    desc = models.TextField(default="", verbose_name="类别描述", help_text="类别描述")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = "问题状态"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class Questions(models.Model):
    """
    问题
    """
    state = models.ForeignKey(QuestionState, verbose_name="案例类目", on_delete=models.CASCADE)
    name = models.CharField(max_length=100, verbose_name="问题名")
    click_num = models.IntegerField(default=0, verbose_name="点击数")
    fav_num = models.IntegerField(default=0, verbose_name="收藏数")
    reply_num = models.IntegerField(default=0, verbose_name="回复数")
    cases_brief = models.TextField(max_length=500, verbose_name="问题简短描述")
    cases_desc = models.TextField(max_length=50000, verbose_name="问题正文内容")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")


    class Meta:
        verbose_name = '问题'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name