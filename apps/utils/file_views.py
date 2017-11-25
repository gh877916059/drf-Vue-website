# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework.response import Response
from rest_framework import status
from rest_framework import views
import os
from APP_Inventor_case_base.settings import REQUEST_HOST
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.permissions import IsAuthenticatedOrReadOnly
import time

class UploadFileView(views.APIView):
    """
    上传文件接口
    """
    authentication_classes = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticatedOrReadOnly,)
    dir_name_to_valid_file_extension = {
        'case_cover_picture': set(['.bmp', '.jpg', '.jpeg', '.png', '.gif']),
        'rich_text_picture': set(['.bmp', '.jpg', '.jpeg', '.png', '.gif'])
    }

    def post(self, request, media_dir=''):
        error_reason_dict = {}
        if len(media_dir) == 0:
            error_reason_dict['detail'] = '请传输上传目录的URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        if media_dir not in self.dir_name_to_valid_file_extension:
            error_reason_dict['detail'] = '请输入合法的上传目录URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        file = request.FILES.get('file')
        file_base_name, file_extension = os.path.splitext(file.name)
        if file_extension not in self.dir_name_to_valid_file_extension[media_dir]:
            error_reason_dict['detail'] = '不支持该文件类型'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        local_base_dir = os.path.dirname(os.path.abspath(__name__))
        user_name = request.user.username
        curr_time_str = time.strftime('-%Y-%m-%d-%H-%M-%S', time.localtime(time.time()))     # 获取当前时间并格式化
        file_name = file_base_name + curr_time_str +  file_extension
        localFileDir = os.path.join(local_base_dir, 'media', media_dir, user_name)
        if not os.path.exists(localFileDir):
            os.makedirs(localFileDir)
        local_file_path = os.path.join(localFileDir, file_name)
        request_url = REQUEST_HOST + '/media/' + media_dir + '/' + user_name + '/' + file_name
        with open(local_file_path, 'wb') as fout:
            for chrunk in file.chunks():
                fout.write(chrunk)
        return_data = { 'location' : request_url }

        return Response(return_data, status=status.HTTP_201_CREATED)