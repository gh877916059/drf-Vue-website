# CSS笔记

## 1. 浮动

浮动核心就一句话：**浮动元素会脱离文档流并向左/向右浮动，直到碰到父元素或者另一个浮动元素。**

浮动会导致父元素高度坍塌

```
// css
.box-wrapper {
  border: 5px solid red;
}
.box-wrapper .box {
  float: left; 
  width: 100px; 
  height: 100px; 
  margin: 20px; 
  background-color: green;
}

// html
<div class="box-wrapper">
  <div class="box"></div>
  <div class="box"></div>
  <div class="box"></div>
</div>
```

![父元素高度坍塌](http://upload-images.jianshu.io/upload_images/1158202-62ba6cdb840c8262.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

clear属性不允许被清除浮动的元素的左边/右边挨着浮动元素，底层原理是在被清除浮动的元素上边或者下边添加足够的清除空间。

```
<div class="box-wrapper">
    <div class="box"></div>
    <div class="box"></div>
    <div class="box"></div>
    <div style="clear:both;"></div>
</div>
```

![清楚浮动](http://upload-images.jianshu.io/upload_images/1158202-95dc95435147ea24.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

强烈推荐对父元素加clearfix的方式清除浮动

## 2. display属性

①对于`display:inline`元素来说，`width`和`height`无效，它的大小由内容的长度和字体的大小决定；而`block`、`inline-block`和`table`则允许

table	此元素会作为块级表格来显示（类似 <table>），表格前后带有换行符。

## 3. width和height

`width`为默认值`auto`时，一般与父元素的`width`值相等；而`height`为默认值`auto`时，一般为了保持宽高比，而自动计算得出

`width:100%`不同于`width:auto`，前者不包括`padding`和`border`，而后者则包括`padding`和`border`。因此如果指定了`width:100%`，而且该元素的`padding`和`border`不为0，则有可能出现子元素超出父元素边界的现象

## 4. :before选择器与:after选择器

在每个<p>元素的内容之前插入新内容：

```
p:before
{ 
content:"台词：";
}
```

## 5. position属性

`relative`以该元素原来的位置作为参考

`relative`与默认值`static`的区别在于：①能否通过`top`或者`left`进行位置的微调；②能否通过`z-index`进行可见优先级的设置

`absolute`以父元素的位置（四个角都有可能）作为参考

在使用`absolute`时，要记得给它的父元素添加`position:relative`或者`position:fixed`

`fixed`与`absolute`相似，但不是以父元素为基准，而是以本浏览器的`window`为基准

## 6. 内容换行

不换行：`white-space: nowrap;`

`word-break`属性规定自动换行的处理方法：

|	值		|		描述		|
|---------------|---------------|
|	normal		|使用浏览器默认的换行规则|
|	break-all	|允许在单词内换行|
|	keep-all	|只能在半角空格或连字符处换行|

## 7. 阴影效果

```
box-shadow: h-shadow v-shadow blur spread color inset;
```


|		值		|			描述			|
|---------------|-----------------------|
|h-shadow		|必需。水平阴影的位置。允许负值|
|v-shadow		|必需。垂直阴影的位置。允许负值|
|blur			|可选。模糊距离			|
|spread			|可选。阴影的尺寸			|
|color			|可选。阴影的颜色			|
|inset			|可选。将外部阴影 (outset) 改为内部阴影|

## 8. min-width与max-width

min-width用于限制最小宽度，max-width用于限制最大宽度

例如：
`width: 50%;min-width: 50px`
`width: 500px;max-width: 50%`

## 9. overflow

1. visible：默认值，超出父容器的部分不作任何处理（任由其超出）
2. hidden：隐藏超出父容器的部分
3. scroll：隐藏超出父容器的部分，然后加滚动条
4. auto：根据浏览器给出不同的策略（一般类似于scroll）

## 10. text-decoration

|		值	|	描述		|
|-----------|-----------|
|	none	|	默认。定义标准的文本	|
|	underline	|	定义文本下的一条线	|
|	overline	|	定义文本上的一条线	|
|	line-through	|	定义穿过文本下的一条线	|
|	blink	|	定义闪烁的文本	|
|	inherit	|	规定应该从父元素继承 text-decoration 属性的值	|

## 11. font-family

该属性规定元素的字体系列，支持序列赋值（如果浏览器不支持第一个字体，则会尝试下一个）


例如
```
CSS选择器1 {
	font-family:"Times New Roman", Georgia, Serif
}
CSS选择器2 {
	font-family:Arial, Verdana, Sans-serif
}
```

## 12. vertical-align

设置元素的垂直对齐方式

|		值		|	描述		|
|---------------|-----------|
|	baseline	|	默认。元素放置在父元素的基线上	|
|	sub			|	垂直对齐文本的下标			|
|	super		|	垂直对齐文本的上标			|
|	top			|	把元素的顶端与行中最高元素的顶端对齐	|
|	text-top	|	把元素的顶端与父元素字体的顶端对齐	|
|	middle		|	把此元素放置在父元素的中部	|
|	bottom		|	把元素的顶端与行中最低的元素的顶端对齐	|
|	text-bottom	|	把元素的底端与父元素字体的底端对齐	|
|	%	 	|	使用 "line-height" 属性的百分比值来排列此元素（允许使用负值）	|
|	inherit		|	规定应该从父元素继承 vertical-align 属性的值	|