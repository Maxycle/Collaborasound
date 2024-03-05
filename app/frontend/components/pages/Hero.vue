<template>
  <div class="relative isolate sm:py-32">
    <img src="/home/maxycle/code/Collaborasound/app/assets/images/Flag_of_Anarcho-capitalism.svg.png" alt=""
      class="absolute inset-0 -z-10 h-full w-full object-fill md:object-center " />
    <div class="mx-auto max-w-7xl px-6 lg:px-8">
      <div class="mx-auto lg:mx-0">
        <h2 class="text-4xl font-bold tracking-tight text-gray-400 sm:text-6xl drop-shadow-lg">What would you like to do??</h2>
        <p class="mt-6 text-lg leading-8 text-gray-400">Look for a musician for your project or look for a project to join
          ?</p>
      </div>
      <div class="mx-auto mt-10 max-w-2xl lg:mx-0 lg:max-w-none">
        <dl class="mt-16 grid grid-cols-4 gap-2 sm:mt-20 p-2 rounded-md bg-gradient-to-l from-anarcapYellow to-black border-2 border-gray-500">
          <div v-for="label in searchParams" class="text-white font-extrabold p-1 rounded drop-shadow-lg">{{ label.name }}</div>
          <div></div>
          <div v-for="param in searchParams" :key="param.name" class="">
            <Autocomplete :heading="param.name" @item-selected="addQueryParamToUrl" />
          </div>
          <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" @click="fetch">Look
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
import Autocomplete from '../search/Autocomplete.vue';
import { ref, onMounted } from 'vue';
import { fetchTracks, fetchMyTracks } from '../../helpers/requests.js';
import { useRouter } from 'vue-router';

const searchParams = [
  { name: 'Genre de zikmu', value: '12' },
  { name: 'Instrument recherchié', value: '300+' },
  { name: 'Où ca ??', value: '40' },
];

let urlToFetch = ref('/tracks');
let instrumentParam = ref('')
let genreParam = ref('')
let locationParam = ref('')
const router = useRouter()

onMounted(() => {
  fetchTracks(urlToFetch.value);
  fetchMyTracks();
});

const fetch = () => {
	fetchTracks(urlToFetch.value)
	router.push('/')
};

const addQueryParamToUrl = (obj) => {
  switch (obj.queryParam) {
    case 'Instrument recherchié':
      instrumentParam.value = obj.queryParamValue
      break;
    case 'Genre de zikmu':
      genreParam.value = obj.queryParamValue
      break;
    case 'Où ca ??':
      locationParam.value = obj.coordinates
      break;
    default:
      urlToFetch.value = '/tracks';
  }
  urlToFetch.value = `/tracks?instrument=${instrumentParam.value}&genre=${genreParam.value}&location=${locationParam.value}`
};
</script>
