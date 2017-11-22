# Vue笔记

1. v-model是v-bind和v-on的语法糖。差不多就相当于下面代码：

```
<input id="a" class="check" name="style" type="checkbox" v-bind:checked="need" v-on:change="change">

data:{
    need:true
},
methods:{
    change:function(e){
        this.need = e.target.value;
    }
}
```