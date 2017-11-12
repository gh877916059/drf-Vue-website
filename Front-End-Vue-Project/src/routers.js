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
    path: '/register',
    name: 'register',
    component(resolve) {
        require.ensure(['./views/register.vue'], () => {
            resolve(require('./views/register.vue'));
        });
    }
}, {
    path: '/login',
    name: 'login',
    component(resolve) {
        require.ensure(['./views/login.vue'], () => {
            resolve(require('./views/login.vue'));
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
