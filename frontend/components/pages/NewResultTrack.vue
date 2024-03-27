<template>
  <Container>
    <div class="w-4/5">
      <div class="flex justify-center space-x-4 pb-4">
        <div class="mx-auto max-w-2xl lg:mx-0 lg:max-w-none">
          <div class="grid grid-cols-2 gap-2 mb-2">
            <div>Instrument(s) added</div>
            <div></div>
            <Autocomplete heading='Instrument recherchié' @item-selected="addParameters"
              @item-inputted="onNewItemInput" />
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold rounded">Upload
              your track</button>
            <div class="flex flex-wrap mt-2">
              <div v-for="item in instrumentsList" :key="item">
                <ParamButton :heading="item" removable @removed="removeParameters" />
              </div>
            </div>
            <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-span-2"
              @click="createTrack">Add your création</button>
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
import { useStore } from '../stores/TrackStore.js'
import { ref, reactive } from 'vue'
import { fetchTracks, fetchMyTracks } from '../../helpers/requests.js'
import { useRouter } from 'vue-router'

const store = useStore()
const router = useRouter()

const trackId = Number($route.params.zeTrackId)
const instrumentParamId = ref(undefined)
const instrumentParamIds = ref([])
const instrumentsList = reactive([])
const newInstrument = ref('')

const createTrack = async () => {
  if (instrumentParamId.value === undefined && newInstrument.value !== '') {
    await createResource('instruments', newInstrument.value, newInstrument, instrumentParamIds)
  }

  try {
    const response = await axios.post('/tracks', {
      music_track: {
        title: store.trackBasicData.title,
        instrument_ids: instrumentParamIds.value,
        music_genre_ids: store.trackBasicData.music_genres.map(item => item.id),
        parent_id: trackId
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
  if (obj.queryParamValue !== '' && !instrumentsList.includes(obj.queryParamValue)) {
    instrumentsList.push(obj.queryParamValue)
    instrumentParamId.value = obj.queryParamId
    instrumentParamIds.value.push(instrumentParamId.value)
  }
}

const onNewItemInput = (obj) => {
  instrumentParamId.value = undefined
  newInstrument.value = obj.queryParamValue
}

const removeParameters = (itemToRemove) => {
  instrumentsList.splice(instrumentsList.indexOf(itemToRemove), 1);
}
</script>
