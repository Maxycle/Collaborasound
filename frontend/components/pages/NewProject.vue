<template>
  <Container>
    <div class="w-4/5">
      <div class="flex justify-center space-x-4 pb-4">
        <div class="mx-auto max-w-2xl lg:mx-0 lg:max-w-none">
          <div class="grid grid-cols-4 gap-2 sm:mt-20">
            <div v-for="label in newProjectParams" :key="label.name">{{ label.name }}</div>
            <div v-for="param in newProjectParams" :key="param.name">
              <Autocomplete :heading="param.name" @item-selected="addParameters" @item-inputted="onNewItemInput" />
            </div>
            <div class="flex flex-wrap mt-2">
              <div v-for="item in genresList" :key="item">
                <ParamButton :heading="item" removable @removed="removeParameters('Genre de zikmu', item)" />
              </div>
            </div>
            <div class="flex flex-wrap mt-2">
              <div v-for="item in instrumentsList" :key="item">
                <ParamButton :heading="item" removable @removed="removeParameters('Instrument recherchié', item)" />
              </div>
            </div>
            <div class="flex flex-wrap mt-2"></div>
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-start-2 col-span-2 mt-2" @click="createTrack">Upload your track</button>
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-start-2 col-span-2" @click="createTrack">Create project</button>
          </div>
        </div>
      </div>
    </div>
  </Container>
</template>

<script setup>
import axios from 'axios'
import Container from '../containers/Container.vue'
import Autocomplete from '../search/Autocomplete.vue'
import ParamButton from '../buttons/ParamButton.vue'
import { ref, reactive } from 'vue'
import { fetchTracks, fetchMyTracks } from '../../helpers/requests.js'
import router from '../../entrypoints/router.js'

const trackTitle = ref('')
const newInstrument = ref('')
const newGenre = ref('')
const instrumentParamIds = ref([])
const genreParamIds = ref([])
let instrumentParamId = ref(undefined)
let genreParamId = ref(undefined)
const urlToFetch = ref('')
const instrumentsList = reactive([])
const genresList = reactive([])
const locationsList = reactive([])
let longitude = ref(undefined)
let latitude = ref(undefined)

const newProjectParams = reactive([
  { name: 'Genre de zikmu', value: '12' },
  { name: 'Instrument recherchié', value: '300+' },
  { name: 'Où ca ??', value: '300+' },
  { name: 'Track title', value: '300+' }
])

const createTrack = async () => {
  if (instrumentParamId.value === undefined && newInstrument.value !== '') {
    await createResource('instruments', newInstrument.value, 'newInstrument', 'instrumentParamIds')
  }

  if (genreParamId.value === undefined && newGenre.value !== '') {
    await createResource('genres', newGenre.value, 'newGenre', 'genreParamIds')
  }

  try {
    const response = await axios.post('/tracks', {
      music_track: {
        title: trackTitle.value,
        instrument_ids: instrumentParamIds.value,
        music_genre_ids: genreParamIds.value,
        longitude: longitude.value,
        latitude: latitude.value
      }
    })

    await Promise.all([
      fetchTracks('/tracks'),
      fetchMyTracks()
    ])

    router.push('/')
    console.log('New track created:', response.data);
  } catch (error) {
    console.error('Error creating track:', error);
  }
}

const createResource = async (endpoint, value, dataProp, idsProp) => {
  try {
    const response = await axios.post(`/${endpoint}`, { [endpoint.slice(0, -1)]: { name: value } });
    dataProp.value = '';
    idsProp.value.push(response.data.id)
    console.log(`New ${endpoint} created:`, response.data);
  } catch (error) {
    console.error(`Error creating ${endpoint}:`, error);
  }
}

const addParameters = (obj) => {
  if (obj.queryParamValue !== '') {
    switch (obj.queryParam) {
      case 'Instrument recherchié':
        if (!instrumentsList.includes(obj.queryParamValue)) {
          instrumentsList.push(obj.queryParamValue)
          instrumentParamId.value = obj.queryParamId
          instrumentParamIds.value.push(instrumentParamId.value)
        }
        break;
      case 'Genre de zikmu':
        if (!genresList.includes(obj.queryParamValue)) {
          genresList.push(obj.queryParamValue)
          genreParamId.value = obj.queryParamId
          genreParamIds.value.push(genreParamId.value)
        }
        break;
      case 'Où ca ??':
        locationsList.push(obj.queryParamValue)
        longitude.value = obj.coordinates[0]
        latitude.value = obj.coordinates[1]
        break;
      default:
        urlToFetch.value = '/tracks';
    }
  }
}

const onNewItemInput = (obj) => {
  switch (obj.queryParam) {
    case 'Instrument recherchié':
      instrumentParamId.value = undefined
      newInstrument.value = obj.queryParamValue
      break;
    case 'Genre de zikmu':
      genreParamId.value = undefined
      newGenre.value = obj.queryParamValue
      break;
    case 'Track title':
      trackTitle.value = obj.queryParamValue
      break;
    default:
      urlToFetch.value = 'kruigh';
  }
}

const removeParameters = (additionalParameter, itemToRemove) => {
  switch (additionalParameter) {
    case 'Instrument recherchié':
      instrumentsList.splice(instrumentsList.indexOf(itemToRemove), 1);
      break;
    case 'Genre de zikmu':
      genresList.splice(genresList.indexOf(itemToRemove), 1);
      break;
    default:
      urlToFetch.value = '/tracks';
  }
}
</script>
