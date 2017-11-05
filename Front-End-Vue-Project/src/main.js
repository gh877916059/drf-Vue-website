import Vue from 'vue';
import Layout from './components/layout';
import routes from './routers';
import VueRouter from 'vue-router';
import VueResource from 'vue-resource';
import store from './vuex/user';
import Utils from './utils'
Vue.use(VueRouter)
// 此后只需要使用this.$http.get或者this.$http.post就可以发起ajax请求
Vue.use(VueResource)
/*
 实例化VueRouter，下面详细剖析mode属性的含义
 vue-router默认使用hash模式——使用URL的hash来模拟一个完整的URL
 如果不想要很丑的hash，我们可以用路由的 history 模式，这种模式充分利用 history.pushState API 来完成URL跳转而无须重新加载页面
 当你使用history模式时，URL就像正常的url，例如 http://yoursite.com/user/id
 但是使用这种模式，最好要在服务端增加一个覆盖所有情况的候选资源：如果 URL 匹配不到任何静态资源，则应该返回同一个index.html页面，这个页面就是我们的app所依赖的页面
 */
let router = new VueRouter({
	mode: 'history',
  routes    // ES6语法糖，相当于routes:routes
})
/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store, // 此后需要用到修改到用户信息时就只需调用this.$store.dispatch('setUserInfo', user);而需要获取用户信息时因为已经绑定好了commputed属性，因此直接获取即可
  // 字符串模板，将会 替换 挂载的元素。挂载元素的内容都将被忽略，除非模板的内容有分发插槽
  template: '<Layout/>',
  components: { Layout },  // ES6语法糖，相当于Layout:Layout
  data: { request_host: 'http://127.0.0.1:8000' },
  methods: Utils
});
