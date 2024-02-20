// application.js
import { createApp } from 'vue';
import App from '../components/pages/App.vue';
import router from './router';
import store from '../store';

import './main.scss';
// Create Vue instance
const app = createApp(App);
app.use(store);
app.use(router);

if (import.meta.env.DEV) {
  // Enable Vue Devtools in development environment
  app.config.devtools = true;
  // If you want to use custom options, you can pass an object
  // app.config.devtools = { host: 'localhost', port: 8098 };
}

app.mount('#app');
