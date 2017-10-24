<template>
    <div>
        <div class="page-cover" v-if="show&&fixHead" @click="showMenus">
        </div>
        <!-- header为对主页的介绍 -->
        <header :class="{'show':show&&fixHead,'fix-header':fixHead,'no-fix':!fixHead}" id="hd">
            <div class="nv-toolbar">
                <div class="toolbar-nav" @click="openMenu" v-if="fixHead">
                </div>
                <span v-text="pageType"></span>
                <!-- <i>标签用于显示斜体文本效果 -->
                <i class="num" v-if="messageCount > 0"> {{messageCount}}</i>
                <!-- 绿色的小纸飞机，用于给用户添加和上传新内容 -->
                <router-link to="/add">
                    <i v-if="needAdd" v-show="!messageCount || messageCount <= 0" class="iconfont add-icon">&#xe60f;</i>
                </router-link>
            </div>
        </header>
        <nv-menu :show-menu="show" :page-type="pageType" :nick-name="nickname" :profile-url="profileimgurl" v-if="fixHead"></nv-menu>
    </div>
</template>

<script>
import $ from 'webpack-zepto';

export default {
    // 模板<template>默认替换挂载元素，如果 replace 选项为 false，模板将插入挂载元素内
    replace: true,
    /*
    props是组件数据的一个字段，期望从父组件传下来，子组件需要显式地用props选项声明props
    跟Vue1很大的一处不同在于Vue2取消了props的双向绑定，改成只能从父级传到子级的单向数据流，初衷当然是好的，为了避免双向绑定在项目中容易造成的数据混乱
    当父组件的值被更改后，子组件的值也随之更改；
    当子组件的值被更改后，父组件的值不会变化，而假如再次修改父组件的值，子组件会再次同步。
    另外需要注意的是，子组件如果要同步绑定，那么子组件的input需要是v-model，而不能是value属性（那样只能单项绑定，且修改子组件的值后会失去绑定）
     */
    props: {
        pageType: String,
        fixHead: Boolean,
        messageCount: Number,
        scrollTop: 0,
        needAdd: {
            type: Boolean,
            default: true
        }
    },
    data () {
        return {
            nickname: '',
            profileimgurl: '',
            show: false
        };
    },
    methods: {
        /*
        overflow：属性规定当内容溢出元素框时发生的事情
        ①visible：默认值。内容不会被修剪，会呈现在元素框之外
        ②hidden：内容会被修剪，并且其余内容是不可见的
        ③scroll：内容会被修剪，但是浏览器会显示滚动条以便查看其余的内容
        ④auto：如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容
        ⑤inherit：规定应该从父元素继承 overflow 属性的值
        */
        openMenu() {
            // $('html, body, #page').addClass('scroll-hide');
            $('body').css('overflow', 'hidden');
            this.show = !this.show;
        },
        showMenus() {
            this.show = !this.show;
            $('body').css('overflow', 'auto');
            // $('html, body, #page').removeClass('scroll-hide');
        }
    },
    components: {
        'nvMenu': require('./menu.vue')
    }
};
</script>
