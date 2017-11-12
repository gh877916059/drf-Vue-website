import Vue from 'vue';
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import filters from './filters';
import routes from './routers';
import Alert from './libs/alert';
import store from './vuex/user';
import FastClick from 'fastclick';
import $ from 'jquery';
import Utils from './utils';
Vue.use(VueRouter);
Vue.use(Alert);
Vue.use(VueResource);

$.ajaxSettings.crossDomain = true;

/*
  Object.keys() 方法会返回一个由一个给定对象的自身可枚举属性组成的数组
  Vue.filter('my-filter', function (value前) { return value后 })用来给Vue注册自定义过滤器
  可以在后续代码中通过var myFilter = Vue.filter('my-filter')重新获取该实例
  或者通过管道在模板或者标签中使用，如{{ msg | uppercase }}或者<input type="password" v-model="psw | validate">
 */
Object.keys(filters).forEach(k => Vue.filter(k, filters[k]));

/*
  实例化VueRouter，下面详细剖析mode属性的含义
  vue-router默认使用hash模式——使用URL的hash来模拟一个完整的URL
  如果不想要很丑的hash，我们可以用路由的 history 模式，这种模式充分利用 history.pushState API 来完成URL跳转而无须重新加载页面
  当你使用history模式时，URL就像正常的url，例如 http://yoursite.com/user/id
  但是使用这种模式，最好要在服务端增加一个覆盖所有情况的候选资源：如果 URL 匹配不到任何静态资源，则应该返回同一个index.html页面，这个页面就是我们的app所依赖的页面
 */
const router = new VueRouter({
    mode: 'history',
    routes  // ES6语法糖，相当于routes:routes
});

// FastClick 是一个简单，易于使用的JS库用于消除在移动浏览器上触发click事件与一个物理Tap(敲击)之间的300延迟
FastClick.attach(document.body);

// 处理刷新的时候vuex被清空但是用户已经登录的情况
if (window.sessionStorage.user) {
    store.dispatch('setUserInfo', JSON.parse(window.sessionStorage.user));
}

/*
 添加身份验证的全局前置导航守卫（登录检查中间件）
 to表示即将要进入的目标$route，而from表示当前导航正要离开的$route，我们可以利用$route进行一些信息的获取
 $route.path：当前路由对象的路径，如'/view/a'
 $rotue.params：关于动态片段（如/user/:username)的键值对信息,如{username: 'paolino'}
 $route.query：请求参数，如/foo?user=1获取到query.user = 1
 $route.router：所属路由器以及所属组件信息
 $route.matched：数组，包含当前匹配的路径中所包含的所有片段所对应的配置参数对象（数组元素来源于routers.js文件中routers数组中的元素）
 $route.name：当前路径名字
 这里是遍历matched数组元素（来自于初始化VueRouter时传入的routes参数）
 next()进行管道中的下一个钩子；next(false)返回到from参数对应的URL；next(其他URL)表示重定向
 */
router.beforeEach((to, from, next) => {
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (store.state.userInfo.userId) {
            next();
        } else {
            next({
                path: '/login',
                query: { redirect: to.fullPath }
            });
        }
    } else {
        next();
    }
});

// 设置vue-resource的请求Host（作用在this.$http.get()或者this.$http.post()方法上）
const requestHost = 'http://127.0.0.1:8000';
Vue.http.options.root = requestHost;

/*
 store中state 的改变，都放置在store自身的 action 中去管理，这种集中式状态管理能够被更容易地理解哪种类型的mutation将会发生，以及它们是如何被触发
 当Vue实例没有el属性时，则该实例尚没有挂载到某个dom中；假如需要延迟挂载，可以在之后手动调用vm.$mount()方法来挂载
 */
new Vue({
    router, // ES6语法糖，相当于router:router
    store,   // ES6语法糖，相当于store:store
    methods: Utils,
    data() {
        return {
            requestHost: requestHost
        };
    },
    mounted: function () {
        this.$nextTick(function () {
            // 使得Foundation框架生效所必须的操作
            $(document).foundation();
        });
    }
}).$mount('#app');
