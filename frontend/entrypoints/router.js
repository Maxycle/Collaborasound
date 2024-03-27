// app/javascript/packs/router.js
import { createRouter, createWebHistory } from 'vue-router'
import useSessionStore from "../stores/SessionStore"
import Home from '../components/pages/Home.vue'
import About from '../components/pages/About.vue'
import Track from '../components/pages/Track.vue'
import NewProject from '../components/pages/NewProject.vue'
import MyTracks from '../components/pages/MyTracks.vue'
import NewResultTrack from '../components/pages/NewResultTrack.vue'
import TrackConversation from '../components/conversations/TrackConversation.vue'
import Messaging from '../components/pages/Messaging.vue'
import UserForm from '../components/UserForm.vue'

const authGuard = (to, next) => {
  const isLoggedIn = useSessionStore().isLoggedIn
  const requiresAuth = to.meta.requiresAuth

  if (isLoggedIn && !requiresAuth) return next({ name: "Home" })
  if (!isLoggedIn && requiresAuth) return next({ name: "Login" })

  return next()
}

const routes = [
	{ path: '/', name: 'Home', component: Home },
	{ path: '/aboutkkk', component: About },
	{ path: '/track/:zeTrackId', name: 'track', component: Track },
	{ path: '/new_project', component: NewProject },
	{ path: '/my_own_tracks', component: MyTracks },
	{ path: '/upload_track/:zeTrackId', name: 'result_track', component: NewResultTrack },
	{ path: '/conversation/:conversationId', name: 'conversation', component: TrackConversation },
	{ path: '/my_messages', component: Messaging },
	{ path: '/login-signin', component: UserForm },
	{ path: "/users/sign_in", name: "Login", component: UserForm, meta: { requiresAuth: false }},
	{ path: "/users/sign_up",name: "Signup", component: UserForm, meta: { requiresAuth: false }},
	{ path: "/users/logout",name: "Logout",meta: { requiresAuth: true },
		beforeEnter: async (_to, _from, next) => {
			await useSessionStore().logout()
			next({ name: "Login" })
		}
	}
];

const router = createRouter({
	history: createWebHistory(),
	routes
})

router.beforeEach((to, _from, next) => {
  authGuard(to, next)
})

export default router
