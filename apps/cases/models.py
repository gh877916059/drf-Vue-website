# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from datetime import datetime
from django.db import models
from DjangoUeditor.models import UEditorField

class CasesCategory(models.Model):
    """
    案例类别
    """
    CATEGORY_TYPE = (
        (1, "一级类目"),
        (2, "二级类目"),
    )

    name = models.CharField(default="", max_length=30, verbose_name="类别名", help_text="类别名")
    code = models.CharField(default="", max_length=30, verbose_name="类别code", help_text="类别code")
    desc = models.TextField(default="", verbose_name="类别描述", help_text="类别描述")
    category_type = models.IntegerField(choices=CATEGORY_TYPE, verbose_name="类目级别", help_text="类目级别")
    parent_category = models.ForeignKey("self", null=True, blank=True, verbose_name="父类目级别", help_text="父目录", related_name="sub_cat")
    is_tab = models.BooleanField(default=False, verbose_name="是否导航", help_text="是否导航")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = "案例类别"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class Cases(models.Model):
    """
    案例
    """
    category = models.ForeignKey(CasesCategory, verbose_name="案例类目")
    name = models.CharField(max_length=100, verbose_name="案例名")
    click_num = models.IntegerField(default=0, verbose_name="点击数")
    fav_num = models.IntegerField(default=0, verbose_name="收藏数")
    reply_num = models.IntegerField(default=0, verbose_name="回复数")
    cases_brief = models.TextField(max_length=500, verbose_name="案例简短描述")
    #cases_desc = UEditorField(verbose_name=u"内容", imagePath="cases/images/", width=1000, height=300, filePath="cases/files/", default='')
    cases_desc = models.TextField(max_length=50000, verbose_name="案例正文内容")
    #cases_front_image = models.ImageField(upload_to="cases/images/", null=True, blank=True, verbose_name="封面图")
    cases_front_image = models.CharField(max_length=200, verbose_name="封面图URL", default='/static/image/fail.jpg')
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '案例'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class CasesImage(models.Model):
    """
    案例轮播图
    """
    cases = models.ForeignKey(Cases, verbose_name="案例", related_name="images")
    image = models.ImageField(upload_to="", verbose_name="图片", null=True, blank=True)
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '案例图片'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.cases.name


class Banner(models.Model):
    """
    首页轮播图
    """
    title = models.CharField(max_length=50, verbose_name="标题", default="暂无标题")
    hyperlink = models.CharField(max_length=200, verbose_name="超链接地址", default="/index")
    image = models.ImageField(upload_to='banner', verbose_name="轮播图片")
    index = models.IntegerField(default=0, verbose_name="轮播顺序")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '首页轮播图'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.title


class HotSearchWords(models.Model):
    """
    热搜词
    """
    keywords = models.CharField(default="", max_length=20, verbose_name="热搜词")
    index = models.IntegerField(default=0, verbose_name="排序")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '热搜词'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.keywords