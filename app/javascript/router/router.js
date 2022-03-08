import { createRouter, createWebHistory } from 'vue-router'
import TopPage from '../pages/TopPage.vue'
import DetailPage from '../pages/DetailPage.vue'
 
const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage
  },
  {
    path: '/:name',
    component: DetailPage
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router