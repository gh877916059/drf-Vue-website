import filters from './filters';
import store from './vuex/store';
import FastClick from 'fastclick';
import axios from 'axios';
import Constants from './constants';
import NetworkCommunication from './vuex/networkCommunication';
import {Vue} from 'vue-property-decorator'
import router from './router';

// 设置axios的请求Host（作用在axios.get()或者axios.post()方法上）
axios.defaults.baseURL = Constants.REQUEST_HOST;
// 为Vue加载过滤器（可以理解为字符串加工处理函数）
Object.keys(filters).forEach(k => Vue.filter(k, filters[k]));

/*
  Object.keys() 方法会返回一个由一个给定对象的自身可枚举属性组成的数组
  Vue.filter('my-filter', function (value前) { return value后 })用来给Vue注册自定义过滤器
  可以在后续代码中通过var myFilter = Vue.filter('my-filter')重新获取该实例
  或者通过管道在模板或者标签中使用，如{{ msg | uppercase }}或者<input type="password" v-model="psw | validate">
 */
Object.keys(filters).forEach(k => Vue.filter(k, filters[k]));

// FastClick 是一个简单，易于使用的JS库用于消除在移动浏览器上触发click事件与一个物理Tap(敲击)之间的300延迟
FastClick.attach(document.body);

console.log('---重新加载页面，尝试从本地存储sessionStorage中恢复Vuex---');
// 一般情况下（使用Vue-router进行页面跳转）Vuex的数据是不会丢失的，但是如果用户手动在浏览器输入网址进行强制跳转时，就需要从sessionStorage中还原
NetworkCommunication.restoreStateFromSessionStorageIfExist();

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
        if (store.state.userName.length > 0) {
            next();
        } else {
            next({
                path: '/index',
                query: { redirect: to.fullPath, needToLogin: 'true' }
            });
        }
    } else {
        next();
    }
});

/*
 store中state 的改变，都放置在store自身的 action 中去管理，这种集中式状态管理能够被更容易地理解哪种类型的mutation将会发生，以及它们是如何被触发
 当Vue实例没有el属性时，则该实例尚没有挂载到某个dom中；假如需要延迟挂载，可以在之后手动调用vm.$mount()方法来挂载
 */
new Vue({store, router}).$mount('#app');
