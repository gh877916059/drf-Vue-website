# Django REST framework笔记

## 一、序列化器

对于drf中的Serializer来说，
所谓序列化（Serialization）就是把model对象转换为一个dict，写法如：serializer =Serializer(model); dict = serializer.data;
所谓反序列化（Deserialization）就是把一个dict转换为model对象，写法如：Serializer(data=dict)
也可以混合使用Serializer(model, data=dict); 利用model对象和dict一起来创建序列化器

Serializer.save()方法会根据对应model的有无进而调用该model对象的create()或者update()方法

如果某个字段添加了**write_only**选项配置，则说明不会在最终返回Response中出现它

## 二、视图

### 1.mixins的定义

1. mixins.ListModelMixin的list()方法：响应get请求然后对queryset使用serializer_class进行序列化操作；

2. mixins.CreateModelMixin的create()方法：响应post请求然后对request.data使用serializer_class进行反序列化操作，最后调用serializer_class.save()；

3. mixins.RetrieveModelMixin的retrieve()方法：响应get请求然后对queryset先进行get(pk=pk)接着使用serializer_class进行序列化操作；

4. mixins.UpdateModelMixin的update()方法：响应put请求然后对queryset先进行get(pk=pk)和request.data使用serializer_class(model, data= dict)，最后调用serializer_class.save()；

5. DestroyModelMixin的destroy()方法：响应delete请求然后对queryset先进行get(pk=pk)得到model对象，最后调用该model对象的delete()方法。

### 2.mixins的用法

1. mixins一般配合generics.GenericAPIView使用，但需要手动将mixins的方法绑定到get、post、put、delete方法上

2. mixins也可以配合viewsets.GenericViewSet使用，这样只需要声明queryset和serializer_class即可，它会自动帮我们完成绑定操作

3. 更进一步，可以直接使用generics.ListCreateAPIView或者generics.RetrieveUpdateDestroyAPIView

### 3.特殊方法

重写视图的def perform_create(self, serializer):方法可以修改在对应serializer_class调用save()方法所进行的动作。

### 4.ViewSet

1. ModelViewSet这个类预定义了各种读写函数；

2. 使用@detail_route注解可以自定义响应函数（用于拓展一般的list、create、retrieve、update、destroy） ，用法如@detail_route(renderer_classes=[renderers.StaticHTMLRenderer])，它默认绑定于get请求，如果想改为post，可以利用methods参数。这个响应函数的URLs默认是函数名， 可以使用url_path修饰器来修改；

3. 可以给.as_view()函数传入额外的参数，实现响应函数和请求方法的绑定，如：

```
snippet_highlight = SnippetViewSet.as_view({
    'get': 'highlight'
}, renderer_classes=[renderers.StaticHTMLRenderer])

urlpatterns = [url(r'^snippets/(?P<pk>[0-9]+)/highlight/$', snippet_highlight, name='snippet-highlight')]
```

4. 可以使用`rest_framework.routers.DefaultRouter`自动完成响应函数和请求方法的绑定，用法如：

```
router = DefaultRouter()
router.register(r'snippets', views.SnippetViewSet)

urlpatterns = [
    url(r'^', include(router.urls))
]
```

## 三、权限管理

1. 在视图对象中添加`permission_classes = (permissions.IsAuthenticatedOrReadOnly,)`或者

```
def get_permissions(self):
    if self.action == "retrieve":
       return [permissions.IsAuthenticated()]
```

2. 只要在html请求加上`Authorization`='JWT ******'的头部，后端就可以解析出当前用户，做法如下：`HttpRequest.user`。

## 四、视图中的预定义各种class

1. permission_classes = (···, ···)
  或者 def get_permissions(self):
		       if self.action == 'retrieve':
  典型代表类：rest_framework.permissions.IsAuthenticated

2. serializer_class = (···, ···)
  或者 def get_serializer_class(self):
  典型代表类：rest_framework.serializers.ModelSerializer

3. queryset = User.objects.all()

4. authentication_classes = (···,···)
  典型代表类：rest_framework_jwt.authentication.JSONWebTokenAuthentication

5. throttle_classes = (···,···)
  典型代表类：
 rest_framework.throttling.UserRateThrottle或者AnonRateThrottle

## 五、缓存机制

```
from rest_framework_extensions.cache.mixins import CacheResponseMixin

让需要增加缓存机制的ViewSet继承CacheResponseMixin即可
```