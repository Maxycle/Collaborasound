// application.js
import { createApp } from 'vue'
import { createPinia } from "pinia"

import App from '../components/pages/App.vue'
import router from './router.js'
import useSessionStore from "../stores/SessionStore.js"
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'

import './main.scss';

const app = createApp(App)
const pinia = createPinia()


// Load JWT from local storage on refresh
const loadAuthToken = async () => {
  const authToken = localStorage.getItem("authToken")
  const authTokenExists = authToken !== "undefined" && authToken !== null

  if (authTokenExists) {
    await useSessionStore(pinia).loginUserWithToken(authToken)
  }
}

loadAuthToken().then(() => {
  app
    .use(router)
    .use(pinia)
    .mount("#app")
})


app.config.errorHandler = (err, instance, info) => {
	console.log('wrong !!! err =>', err)
	console.log('wrong !!! instance =>', instance)
	console.log('wrong !!! info =>', info)
}
if (import.meta.env.DEV) {
	// Enable Vue Devtools in development environment
	app.config.devtools = true;
}
