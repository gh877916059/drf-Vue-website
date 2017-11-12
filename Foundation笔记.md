# Foundation笔记

## 1.表单验证组件Abide

1. 添加自定义验证pattern的写法（要写在$(document).foundation();之前）：

```
window.Foundation.Abide.defaults.patterns['not-shorter-than-six'] = /^.{6,}$/;
```

2. 添加自定义验证器的写法（要写在$(document).foundation();之前）：

```
window.Foundation.Abide.defaults.validators['greater_than'] = function($el,required,parent) {……};
```

3. 当表单错误提示项&lt;span class="form-error"&gt;无法与对应的&lt;input&gt;位于同一个区块（如&lt;div class="input-group"&gt;）中时，可以使用**data-form-error-for="input元素的id"**属性来指定。


