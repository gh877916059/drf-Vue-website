# Vue笔记

## 1. V-model原理

v-model是v-bind和v-on的语法糖。差不多就相当于下面代码：

```
<input id="a" class="check" name="style" type="checkbox" v-bind:checked="need" v-on:input="update">

data:{
    need:true
},
methods:{
    update:function(e){
        this.need = e.target.value;
    }
}
```

## 2. 组件间通信

### 2.1. 父组件往子组件传数据

在子组件中声明`props`，父组件在声明子组件时传入该数据。通过子组件的标签直接赋字面量，其类型总为`string`

### 2.2. 父组件触发子组件的函数

父组件在声明子组件时指定属性`ref="自定义应用名"`，然后就可以通过`this.$refs.自定义引用名`来访问该子组件

### 2.3. 子组件触发父组件的函数

父组件在声明子组件时使用`v-on:事件名="要调用的函数"`，子组件使用`this.$emit(事件名);`

### 2.4. 其他情况

使用`Vuex`+`watch`功能