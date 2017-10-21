# -*- coding: utf-8 -*-
__author__ = 'HymanLu'

import redis

r = redis.Redis(host='119.23.69.178', port=6379,db=0, password='87319106')

r.set('name', 'zhangsan')   #添加
print (r.get('name'))   #获取