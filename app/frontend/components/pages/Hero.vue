<template>
  <div class="relative isolate bg-gray-900 py-24 sm:py-32">
    <img src="https://source.unsplash.com/ptVBlniJi50" alt=""
      class="absolute inset-0 -z-10 h-full w-full object-cover object-right md:object-center opacity-80" />
    <div class="mx-auto max-w-7xl px-6 lg:px-8">
      <div class="mx-auto lg:mx-0">
        <h2 class="text-4xl font-bold tracking-tight text-white sm:text-6xl">What would you like to do??</h2>
        <p class="mt-6 text-lg leading-8 text-gray-300">Look for a musician for your project or look for a project to join
          ?</p>
      </div>
      <div class="mx-auto mt-10 max-w-2xl lg:mx-0 lg:max-w-none">
        <dl class="mt-16 grid grid-cols-4 gap-2 sm:mt-20">
          <div v-for="label in searchParams" class="text-white">{{ label.name }}</div>
          <div></div>
          <div v-for="param in searchParams" :key="param.name" class="">
            <Autocomplete :heading="param.name" @item-selected="addQueryParamToUrl" />
          </div>
          <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" @click="fetchTracks">Look
            for a project</button>
          <button
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-start-2 col-span-2 mt-4"><router-link
              to="/new_project" class="">Start a new collaboration</router-link></button>
        </dl>
      </div>
    </div>
  </div>
</template>
  
<script setup>
import { useStore } from 'vuex';
import { useRouter } from 'vue-router';
import Autocomplete from '../search/Autocomplete.vue';
import { ref, onMounted } from 'vue';
import axios from 'axios';

const searchParams = [
  { name: 'Genre de zikmu', value: '12' },
  { name: 'Instrument recherchié', value: '300+' },
  { name: 'Où ca ??', value: '40' },
];

const store = useStore();
const router = useRouter()
let urlToFetch = ref('/tracks');
let instrumentParam = ref('')
let genreParam = ref('')
let locationParam = ref('')

const fetchTracks = async () => {
  try {
    const fetchedTracks = await store.dispatch('searchTracks', {
      axios: axios.create(),
      urlToFetch: urlToFetch.value,
    });
    console.log('Fetched tracks:', fetchedTracks);
    router.push('/')
  } catch (error) {
    console.error('Error fetching tracks:', error);
  }
};

onMounted(fetchTracks)

const addQueryParamToUrl = (obj) => {
  switch (obj.queryParam) {
    case 'Instrument recherchié':
      instrumentParam.value = obj.queryParamValue
      break;
    case 'Genre de zikmu':
      genreParam.value = obj.queryParamValue
      break;
    case 'Où ca ??':
      locationParam.value = obj.queryParamValue
      break;
    default:
      urlToFetch.value = '/tracks';
  }
  urlToFetch.value = `/tracks?instrument=${instrumentParam.value}&genre=${genreParam.value}&location=${locationParam.value}`
};
</script>
