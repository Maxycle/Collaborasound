// app/javascript/packs/router.js
import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/pages/Home.vue'
import About from '../components/pages/About.vue'
import Track from '../components/pages/Track.vue'
import NewProject from '../components/pages/NewProject.vue'
import MyTracks from '../components/pages/MyTracks.vue'
import NewResultTrack from '../components/pages/NewResultTrack.vue'
import TrackConversation from '../components/conversations/TrackConversation.vue'


const routes = [
  { path: '/', component: Home },
  { path: '/aboutkkk', component: About },
  { path: '/track/:zeTrackId', name: 'track', component: Track },
  { path: '/new_project', component: NewProject },
	{ path: '/my_own_tracks', component: MyTracks },
	{ path: '/upload_track/:zeTrackId', name: 'result_track', component: NewResultTrack },
	{ path: '/conversation/:conversationId',name: 'conversation', component: TrackConversation }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;