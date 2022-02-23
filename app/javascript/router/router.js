import { createRouter, createWebHistory } from 'vue-router'
import TopPage from '../pages/TopPage.vue'
 
const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage
  },
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router