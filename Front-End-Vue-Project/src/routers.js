import IndexPage from './pages/index'
import DetailPage from './pages/detail'
import OrderListPage from './pages/orderList'
import DetailAnaPage from './pages/detail/analysis'
import DetailCouPage from './pages/detail/count'
import DetailForPage from './pages/detail/forecast'
import DetailPubPage from './pages/detail/publish'

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
];

export default routers;
