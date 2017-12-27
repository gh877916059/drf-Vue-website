/*
  在webpack中，如果某个JS文件没有被打包，而是独立导出，则需要通过jsonp来异步加载
  原理类似于：
  var head = document.getElementsByTagName('head')[0];
  var script = document.createElement('script');
  script.async = true;
  script.src = "http://map.baidu.com/.js"
  head.appendChild(script);
  而我们的require.ensure(dependencies: String[], callback: function(require), chunkName: String)就是负责完成这一任务
 */
import {Vue} from "vue-property-decorator";
import VueRouter from "vue-router";
Vue.use(VueRouter);

const routes = [{
    path: '/',
    name: 'home',
    component(resolve) {
        require.ensure(['./views/index.vue'], () => {
            resolve(require('./views/index.vue'));
        });
    }
}, {
    path: '/index',
    name: 'index',
    component(resolve) {
        require.ensure(['./views/index.vue'], () => {
            resolve(require('./views/index.vue'));
        });
    }
}, {
    path: '/editCase',
    name: 'editCase',
    component(resolve) {
        require.ensure(['./views/editCase.vue'], () => {
            resolve(require('./views/editCase.vue'));
        });
    },
    meta: { requiresAuth: true }
}, {
    path: '/viewCase/:id',
    name: 'viewCase',
    component(resolve) {
        require.ensure(['./views/viewCase.vue'], () => {
            resolve(require('./views/viewCase.vue'));
        });
    }
}, {
    path: '/showAllCases',
    name: 'showAllCases',
    component(resolve) {
        require.ensure(['./views/showAllCases.vue'], () => {
            resolve(require('./views/showAllCases.vue'));
        });
    }
}, {
    path: '/showAllQuestions',
    name: 'showAllQuestions',
    component(resolve) {
        require.ensure(['./views/showAllQuestions.vue'], () => {
            resolve(require('./views/showAllQuestions.vue'));
        });
    }
}, {
    path: '/editQuestion',
    name: 'editQuestion',
    component(resolve) {
        require.ensure(['./views/editQuestion'], () => {
            resolve(require('./views/editQuestion'));
        });
    },
    meta: { requiresAuth: true }
}, {
    path: '/viewQuestion/:id',
    name: 'viewQuestion',
    component(resolve) {
        require.ensure(['./views/viewQuestion.vue'], () => {
            resolve(require('./views/viewQuestion.vue'));
        });
    }
}, {
    path: '*',
    component(resolve) {
        require.ensure(['./views/index.vue'], () => {
            resolve(require('./views/index.vue'));
        });
    }
}];

/*
  实例化VueRouter，下面详细剖析mode属性的含义
  vue-router默认使用hash模式——使用URL的hash来模拟一个完整的URL
  如果不想要很丑的hash，我们可以用路由的 history 模式，这种模式充分利用 history.pushState API 来完成URL跳转而无须重新加载页面
  当你使用history模式时，URL就像正常的url，例如 http://yoursite.com/user/id
  但是使用这种模式，最好要在服务端增加一个覆盖所有情况的候选资源：如果 URL 匹配不到任何静态资源，则应该返回同一个index.html页面，这个页面就是我们的app所依赖的页面
 */
const router = new VueRouter({
    mode: 'history',
    routes,  // ES6语法糖，相当于routes:routes
});

export function jumpToThisPage(path: string, query?: Object) {
    if (query) {
        path = path + '?';
        for (var key in query) {
            path = path + key + '=' + query[key];
        }
    }
    router.push({ path });
}

export default router;
