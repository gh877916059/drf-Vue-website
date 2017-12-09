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
    question_state_id = serializers.IntegerField(required=True, write_only=True, label="问题状态ID", help_text="问题状态ID")

    def validate(self, attrs):
        question_state_id = attrs['question_state_id']
        question_state = QuestionState.objects.get(Q(id=question_state_id))
        attrs['state'] = question_state
        del attrs['question_state_id']
        return attrs

    class Meta:
        model = Questions
        fields = "__all__"
        fields = ("question_state_id", "name", "cases_brief", "cases_desc")