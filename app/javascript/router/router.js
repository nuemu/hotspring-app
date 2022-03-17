import { createRouter, createWebHistory } from 'vue-router'
import TopPage from '../pages/TopPage.vue'
import DetailPage from '../pages/DetailPage.vue'
import ExplorePage from '../pages/ExplorePage.vue'
 
const routes = [
  {
    path: '/',
    name: 'TopPage',
    component: TopPage
  },
  {
    path: '/explore',
    name: 'Explore',
    component: ExplorePage
  },
  {
    path: '/hotspring/:name',
    component: DetailPage
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router