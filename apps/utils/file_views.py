# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

from rest_framework.response import Response
from rest_framework import status
from rest_framework import views
import os
from APP_Inventor_case_base.settings import REQUEST_HOST
from rest_framework_jwt.authentication import JSONWebTokenAuthentication
from rest_framework.permissions import IsAuthenticatedOrReadOnly

class UploadFileView(views.APIView):
    """
    上传文件接口
    """
    authentication_classes = (JSONWebTokenAuthentication,)
    permission_classes = (IsAuthenticatedOrReadOnly,)
    dir_name_to_valid_file_extension = {
        'case_cover_picture': set(['bmp', 'jpg', 'jpeg', 'png', 'gif']),
        'rich_text_picture': set(['bmp', 'jpg', 'jpeg', 'png', 'gif'])
    }

    def post(self, request, mediaDir=''):
        error_reason_dict = {}
        if len(mediaDir) == 0:
            error_reason_dict['detail'] = '请传输上传目录的URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        if mediaDir not in self.dir_name_to_valid_file_extension:
            error_reason_dict['detail'] = '请输入合法的上传目录URL参数'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        file = request.FILES.get('file')
        fileName = file.name
        file_extension = os.path.splitext(fileName)[1][1:]
        if file_extension not in self.dir_name_to_valid_file_extension[mediaDir]:
            error_reason_dict['detail'] = '不支持该文件类型'
            return Response(error_reason_dict, status=status.HTTP_400_BAD_REQUEST)
        baseDir = os.path.dirname(os.path.abspath(__name__))
        userName = request.user.username
        localFileDir = os.path.join(baseDir, 'media', mediaDir, userName)
        if not os.path.exists(localFileDir):
            os.makedirs(localFileDir)
        localFileName = os.path.join(localFileDir, fileName)
        requestURL = REQUEST_HOST + '/media/' + mediaDir + '/' + userName + '/' + fileName
        with open(localFileName, 'wb') as fout:
            for chrunk in file.chunks():
                fout.write(chrunk)
        return_data = { 'location' : requestURL }

        return Response(return_data, status=status.HTTP_201_CREATED)