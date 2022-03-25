import { createRouter, createWebHistory } from 'vue-router'
import TopPage from '../pages/TopPage.vue'
import DetailPage from '../pages/DetailPage/DetailPage.vue'
import Admin from '../admin/Admin.vue'
import store from '../store/index'

const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage
  },
  {
    path: '/hotspring/:name',
    component: DetailPage
  },
  {
    path: '/admin',
    component: Admin,
    meta: { requiredAdmin: true }
  },
  {
    path: '/:pathMatch(.*)*',
    component: TopPage
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser').then((authUser) => {
    if(to.matched.some(record => record.meta.requiredAdmin)){
      store.dispatch('users/fetchAdmin').then((admin) => {
        if(!admin){
          next({ name: 'TopPage' });
        } else {
          next();
        }
      })
    }
    else next();
  })
});

export default router