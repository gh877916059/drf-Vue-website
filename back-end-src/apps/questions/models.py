# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from datetime import datetime
from django.db import models

class Questions(models.Model):
    """
    问题
    """
    QUESTION_STATE = (
        (1, "待解决"),
        (2, "已解决"),
        (3, "悬赏")
    )
    state = models.IntegerField(choices=QUESTION_STATE, verbose_name="问题状态", help_text="问题状态", default=1)
    name = models.CharField(max_length=100, verbose_name="问题名")
    click_num = models.IntegerField(default=0, verbose_name="点击数")
    fav_num = models.IntegerField(default=0, verbose_name="收藏数")
    reply_num = models.IntegerField(default=0, verbose_name="回复数")
    vote_num = models.IntegerField(default=0, verbose_name="点赞数")
    question_brief = models.TextField(max_length=500, verbose_name="问题简短描述")
    question_desc = models.TextField(max_length=50000, verbose_name="问题正文内容")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")
    label_1 = models.CharField(max_length=20, verbose_name="标签名1", null=True, blank=True)
    label_2 = models.CharField(max_length=20, verbose_name="标签名2", null=True, blank=True)
    label_3 = models.CharField(max_length=20, verbose_name="标签名3", null=True, blank=True)
    label_4 = models.CharField(max_length=20, verbose_name="标签名4", null=True, blank=True)
    label_5 = models.CharField(max_length=20, verbose_name="标签名5", null=True, blank=True)

    class Meta:
        verbose_name = '问题'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class Answers(models.Model):
    """
    回答
    """
    question = models.ForeignKey(Questions, verbose_name="问题", on_delete=models.CASCADE)
    reply_num = models.IntegerField(default=0, verbose_name="回复数")
    vote_num = models.IntegerField(default=0, verbose_name="点赞数")
    answer_desc = models.TextField(max_length=50000, verbose_name="回答正文内容")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '回答'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class SubAnswers(models.Model):
    """
    某个问题的回答跟帖
    """
    parent_answer = models.ForeignKey(Answers, verbose_name="父回答", on_delete=models.CASCADE)
    index = models.IntegerField(default=0, verbose_name="位于回答跟帖中的索引下标")
    sub_answer_desc = models.TextField(max_length=50000, verbose_name="跟帖正文内容")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '回答跟帖'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name