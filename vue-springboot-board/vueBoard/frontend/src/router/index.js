import Vue from 'vue'
import Router from 'vue-router'

/* import Add from '@/components/Add' */

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'VueBoard',
      component: () => import("@/components/VueBoard")
    },
    {
      path: '/add',
      name: 'Add',
      component: () => import("@/components/Add")
    },
    {
      path: '/detail/:num',
      name: 'Detail',
      component: () => import("@/components/Detail"),
      props: true
    }
  ]
})
