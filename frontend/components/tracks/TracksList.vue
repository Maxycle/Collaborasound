<template>
  <div class="w-4/5">
    <div class="flex items-center justify-center w-full p-4">
      <div class="w-4/5">
        <p v-if="isMyTracks" class="text-2xl font-bold flex justify-center">My tracks</p>
        <p v-else-if="isResult" class="text-2xl font-bold flex justify-center">People's collaborations</p>
        <div v-for="track in currentTrackList" :key="track.title" class="">
          <TrackCard :trackId="track.id" :parentTrackId="trackId" class="w-full my-6" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import axios from 'axios';
import TrackCard from './TrackCard.vue';

const isMyTracks = ref(false);
const isResult = ref(false);
const trackId = ref(undefined);
const childrenIds = ref([]);
const trackListIds = ref([]);
const myTrackListIds = ref([]);

const currentTrackList = ref([]);

onMounted(() => {
  if (trackId.value) {
    fetchTrackChildrenIds();
  } else {
    currentTrackList.value = isResult.value ? childrenIds.value : (isMyTracks.value ? myTrackListIds.value : trackListIds.value);
  }
});

async function fetchTrackChildrenIds() {
  try {
    const response = await axios.get(`/index_results/${trackId.value}`);
    childrenIds.value = response.data;
    currentTrackList.value = childrenIds.value;
  } catch (error) {
    console.error('Error fetching tracks:', error);
  }
}
</script>
