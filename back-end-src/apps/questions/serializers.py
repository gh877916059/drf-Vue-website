# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework import serializers
from django.db.models import Q
from questions.models import Questions, QuestionState

class QuestionStateSerializer(serializers.ModelSerializer):
    class Meta:
        model = QuestionState
        fields = "__all__"

class GetQuestionsSerializer(serializers.ModelSerializer):
    question_state = QuestionStateSerializer()

    class Meta:
        model = Questions
        fields = "__all__"

class PostQuestionsSerializer(serializers.ModelSerializer):

    class Meta:
        model = Questions
        fields = ("name", "label_1", "label_2", "label_3", "label_4", "label_5", "question_desc")