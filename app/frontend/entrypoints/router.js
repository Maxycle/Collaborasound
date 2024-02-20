// app/javascript/packs/router.js
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/pages/Home.vue'
import About from '../components/pages/About.vue'
import Track from '../components/pages/Track.vue'
import NewProject from '../components/pages/NewProject.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/aboutkkk', component: About },
  { path: '/track/:zeTrackId', name: 'track', component: Track },
  { path: '/new_project', component: NewProject },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;