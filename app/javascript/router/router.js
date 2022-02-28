import { createRouter, createWebHistory } from 'vue-router'
import TopPage from '../pages/TopPage.vue'
import Explore from '../pages/Explore.vue'
 
const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage
  },
  {
    path: '/explore',
    name: 'Explore',
    component: Explore
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router