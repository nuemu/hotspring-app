import { createRouter, createWebHistory } from 'vue-router'
import TopPage from '../pages/TopPage/TopPage.vue'
import ExplorePage from '../pages/ExplorePage.vue'
import DetailPage from '../pages/DetailPage/DetailPage.vue'
import store from '../store/index'
import HotspringsPage from '../pages/HotspringsPage/HotspringsPage.vue'

import Register from '../pages/Authentication/RegisterPage.vue'
import Login from '../pages/Authentication/LoginPage.vue'
import User from '../pages/UserPage/UserPage.vue'
import Mountain from '../pages/MountainPage/PageBase.vue'
import HowTo from '../pages/HowToPage/HowTo.vue'

const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage,
  },
  {
    path: '/login',
    component: Login
  },
  {
    path: '/user/:id',
    name: 'user',
    component: User
  },
  {
    path: '/register',
    component: Register
  },
  {
    path: '/mountains',
    component: Mountain
  },
  {
    path: '/hotsprings',
    component: HotspringsPage
  },
  {
    path: '/howto',
    component: HowTo,
  },
  {
    path: '/hotspring/:name',
    component: DetailPage
  },
  {
    path: '/explore',
    component: ExplorePage,
    name: 'Explore'
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
  store.dispatch('users/csrf').then((token) => {
    store.dispatch('users/fetchAuthUser').then((user) => {
      if(!user && to.name === 'Explore') next('/login');
      else next();
    })
  })
});

export default router