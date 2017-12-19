from django.shortcuts import render_to_response
from rest_framework import views
import os

class HomePageView(views.APIView):
    def get(self, request):
        return render_to_response("index.html")