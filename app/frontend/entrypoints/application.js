// application.js
import { createApp } from 'vue';
import App from '../components/pages/App.vue';
import router from './router';
import store from '../store';
import '@mapbox/mapbox-gl-geocoder/dist/mapbox-gl-geocoder.css'

import './main.scss';

const app = createApp(App);
app.use(store);
app.use(router);
app.config.errorHandler = (err, instance, info) => {
  console.log('wrong !!! err =>', err)
	console.log('wrong !!! instance =>', instance)
	console.log('wrong !!! info =>', info)
}
if (import.meta.env.DEV) {
  // Enable Vue Devtools in development environment
  app.config.devtools = true;
}

app.mount('#app');
