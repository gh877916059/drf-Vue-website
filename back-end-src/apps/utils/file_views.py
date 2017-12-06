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
from cases.models import Cases

class FileInfoRecorder():
    local_base_dir = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    dir_name_to_valid_file_extension = {
        'case_cover_picture': set(['.bmp', '.jpg', '.jpeg', '.png', '.gif']),
        'rich_text_picture': set(['.bmp', '.jpg', '.jpeg', '.png', '.gif'])
    }

class UploadFileView(views.APIView, FileInfoRecorder):
    """
    上传文件接口
    """
    authentication_classes = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticatedOrReadOnly,)

    def post(self, request, media_dir=''):
        error_reason_dict = {}
        if len(media_dir) == 0:
            error_reason_dict['detail'] = '请传输上传目录的URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        if media_dir not in self.dir_name_to_valid_file_extension:
            error_reason_dict['detail'] = '请输入合法的上传目录URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        file = request.FILES.get('file')
        if not file:
            file = request.FILES.get('file_data')
        file_base_name, file_extension = os.path.splitext(file.name)
        if file_extension not in self.dir_name_to_valid_file_extension[media_dir]:
            error_reason_dict['detail'] = '不支持该文件类型'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        user_name = request.user.username
        curr_time_str = time.strftime('-%Y-%m-%d-%H-%M-%S', time.localtime(time.time()))     # 获取当前时间并格式化
        file_name = file_base_name + curr_time_str +  file_extension
        localFileDir = os.path.join(self.local_base_dir, 'media', media_dir, user_name)
        if not os.path.exists(localFileDir):
            os.makedirs(localFileDir)
        local_file_path = os.path.join(localFileDir, file_name)
        request_url = REQUEST_HOST + '/media/' + media_dir + '/' + user_name + '/' + file_name
        with open(local_file_path, 'wb') as fout:
            for chrunk in file.chunks():
                fout.write(chrunk)
        return_data = { 'location' : request_url }

        return Response(return_data, status=status.HTTP_201_CREATED)

class DeleteFileView(views.APIView, FileInfoRecorder):
    """
    删除文件接口
    """
    authentication_classes = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticatedOrReadOnly,)

    def post(self, request, media_dir=''):
        error_reason_dict = {}
        if len(media_dir) == 0:
            error_reason_dict['detail'] = '请传输文件目录的URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        if media_dir not in self.dir_name_to_valid_file_extension:
            error_reason_dict['detail'] = '请输入合法的文件目录URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        file_name = request.data.get('file_name')
        if not file_name:
            error_reason_dict['detail'] = '请传输要删除文件的文件名'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        user_name = request.user.username
        localFileDir = os.path.join(self.local_base_dir, 'media', media_dir, user_name)
        local_file_path = os.path.join(localFileDir, file_name)
        if not os.path.exists(local_file_path):
            error_reason_dict['detail'] = '指定文件不存在'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        else:
            os.remove(local_file_path)
        case_id = request.data.get('case_id')
        if len(case_id) > 0:
            cases = Cases.objects.filter(id=case_id)
            for case in cases:
                case.cases_front_image = '/static/image/fail.jpg'
                print('---重置封面图为空成功---')
                case.save()
        return Response(status=status.HTTP_204_NO_CONTENT)