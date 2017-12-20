# BootStrap笔记

## 1. 响应式栅格尺寸标准

![Alt text](./响应式栅格尺寸标准.png) 

```
// 超小型是默认实现
// 小型
media (min-width: 768px) {
.container { width: 750px; }
}/
// 中型
media (min-width: 992px) {
.container { width: 970px; }
}/
// 大型
@media (min-width: 1200px) {
.container { width: 1170px; }
}
```

## 2. 响应式显示与隐藏

![Alt text](./响应式显示与隐藏.png)

```
@media (max-width: 767px) {
/*在小于768像素的设备上的显示情况*/
}@
media (min-width: 768px) and (max-width: 991px) {
/*在768像素和992像素之间的设备上的显示情况*/
}@
media (min-width: 992px) and (max-width: 1199px) {
/*在992像素和1200像素之间的设备上的显示情况*/
}@
media (min-width: 1200px) {
/*在大于1200像素的设备上的显示情况*/
}
```


## 3. CSS组件的8种基本类型

1. 基础样式：btn、alert
2. 颜色样式：btn-info、alert-success
3. 尺寸样式：btn-xs、btn-sm、btn-lg
4. 状态样式：active、disabled
5. 特殊元素样式：dropdown-menu>li>a:hover
6. 并列元素样式：btn-group.btn+.btn
7. 嵌套子元素样式：btn-group .btn-group
8. 动画样式：progress.active

## 4. JavaScript插件的统一实现步骤

以alert插件为例
```
// 1. 声明立即调用的函数
function ($) {
	"use strict";
	
	// 2. 定义插件类及相关原型方法
	var dismiss = '[data-dismiss="alert"]';
	var Alert = function (el) {
		$(el).on('click', dismiss, this.close);
	};
	Alert.prototype.close = function (e) {
		// 关闭警告框的主要代码
	}

	3. 在jQuery上定义插件并重设插件构造函数
	var old = $.fn.alert
	$.fn.alert = function (option) {
		return this.each(function () {
			// 遍历所有符合规则的元素，在其上绑定插件的实例
		})
	}
	$.fn.alert.Constructor = Alert;

	// 4. 防冲突处理
	$.fn.alert.noConflict = function () {
		$.fn.alert = old;
		return this;
	}

	// 5. 绑定各种触发事件(data-api)
	$(document).on('click.bs.alert.data-api', dismiss, Alert.prototype.close);
}
```

## 5. 响应式图片
```
.img-responsive {
display: block;
max-width: 100%;
height: auto;
}
```

## 6. 容器（居中且自动调整宽度）
```
@media (min-width: 1200px)
bootstrap.min.css:1601
.container {
    width: 1170px;
}
@media (min-width: 992px)
bootstrap.min.css:1596
.container {
    width: 970px;
}
@media (min-width: 768px)
bootstrap.min.css:1591
.container {
    width: 750px;
}

.container {padding-right: 15px;
padding-left: 15px;
margin-right: auto; /*左右居中的设置*/
margin-left: auto;
}
```