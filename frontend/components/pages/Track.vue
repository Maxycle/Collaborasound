<template>
  <Container class="overflow-y-auto">
    <div class="w-4/5 flex flex-col min-h-full">
      <div class="pb-4"><span class="font-bold">{{ author }}</span> needs some <span class="font-bold">{{ instrument ||
        'stuff' }}</span> to make some <span class="font-bold">{{ genre || 'weird' }}</span> muzik for the song :
      </div>
      <h1 class="flex justify-center pb-4"> "{{ trackTitle }}""</h1>
      <div class="flex justify-center space-x-4 pb-4">
        <AnarcapButton class="transition hover:-translate-x-6 hover:scale-110 duration-300 shadow-lg shadow-zinc-600">
          <span class="relative">listen to "{{ trackTitle
            }}"</span>
        </AnarcapButton>
        <AnarcapButton class="transition hover:z-10 hover:scale-110 duration-300 shadow-lg shadow-zinc-600"><span
            class="relative">download "{{ trackTitle
            }}"</span></AnarcapButton>
        <AnarcapButton class="transition hover:translate-x-6 hover:scale-110 duration-300 shadow-lg shadow-zinc-600">
          <span class="relative"><router-link :to="{ name: 'result_track', params: { zeTrackId: trackId } }">upload your
              track/result</router-link></span>
        </AnarcapButton>
      </div>
      <div class="flex justify-center">
        <TracksList isResult :trackId="trackId" class="justify-center" />
      </div>
    </div>
  </Container>
</template>

<script setup>
import Container from '../containers/Container.vue'
import TracksList from '../tracks/TracksList.vue'
import AnarcapButton from '../buttons/AnarcapButton.vue'
import { useRoute } from 'vue-router'
import { useStore } from '../stores/TrackStore.js'

const route = useRoute()
const trackId = Number(route.params.zeTrackId)
const store = useStore()

// You can directly use `store.trackBasicData` since it's reactive and available for use
const genre = store.trackBasicData.music_genres.map(item => item.name).join('/')
const author = store.trackBasicData.author.first_name
const instrument = store.trackBasicData.instruments.map(item => item.name).join('/')
const band = store.trackBasicData.band
const trackTitle = store.trackBasicData.title
</script>

