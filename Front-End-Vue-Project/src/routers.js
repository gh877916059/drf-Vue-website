import IndexPage from './pages/index'
import DetailPage from './pages/detail'
import OrderListPage from './pages/orderList'
import DetailAnaPage from './pages/detail/analysis'
import DetailCouPage from './pages/detail/count'
import DetailForPage from './pages/detail/forecast'
import DetailPubPage from './pages/detail/publish'

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

const routers = [
  {
    path: '/',
    component: IndexPage
  },
  {
    path: '/orderList',
    component: OrderListPage
  },
  {
    path: '/detail',
    component: DetailPage,
    redirect: '/detail/analysis',
    children: [
      {
        path: 'analysis',
        component: DetailAnaPage
      },
      {
        path: 'count',
        component: DetailCouPage
      },
      {
        path: 'forecast',
        component: DetailForPage
      },
      {
        path: 'publish',
        component: DetailPubPage
      }
    ]
  }
]
};

export default routers;
