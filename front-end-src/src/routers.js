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

const routers = [{
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
    path: '*',
    component(resolve) {
        require.ensure(['./views/index.vue'], () => {
            resolve(require('./views/index.vue'));
        });
    }
}];

export default routers;
