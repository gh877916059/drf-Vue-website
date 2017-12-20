# jQuery笔记

1. `$(document).ready(function(){});`可以简写成`$(function(){});`
2. 创建元素：`$('<input type="file">')`
3. 获取/修改HTML属性（如`class`）：`$element.attr()`
4. 获取/修改DOM属性（如`files`）：`$element.prop()`
5. 针对`class`属性的操作函数：`hasClass(...)`、`removeClass(...)`、`addClass(...)`、`toggleClass(...)`
6. 获取/修改样式：`$element.css(...)`
7. 修改函数调用的上下文：`$element.proxy(function,context)`、`$element.proxy(context,name)`
8. `$element.selector`代表当初进行选择时传入的字符串（已过时？？）