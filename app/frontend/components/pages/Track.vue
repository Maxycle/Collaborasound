<template>
	<Container>
		<div class="w-4/5">
			<div>{{ author }} in {{ band }} needs some {{ instrument }} to play some {{ genre }}</div>
			<div class="flex justify-center space-x-4 pb-4">
				<div class="border-2 border-red-400 bg-green-300 rounded-2xl p-4">listen to ze Track</div>
				<div class="border-2 border-red-400 bg-green-300 rounded-2xl p-4">download ze track</div>
				<div class="border-2 border-red-400 bg-green-300 rounded-2xl p-4">upload your track/result</div>
			</div>
			<div class="flex justify-center">
				<TracksList isResult :trackId="trackId" class="justify-center" />
			</div>
		</div>
	</Container>
</template>

<script>
import Container from '../containers/Container.vue'
import TracksList from '../tracks/TracksList.vue'
import { mapGetters } from 'vuex'; // Import mapGetters

export default {
	components: {
		Container,
		TracksList
	},

	data() {
		return {
			trackId: Number(this.$route.params.zeTrackId)
		}
	},

	computed: {
		...mapGetters(['trackBasicData']),
		genre() {
      return this.trackBasicData.music_genre;
    },
    author() {
      return this.trackBasicData.author;
    },
    instrument() {
      return this.trackBasicData.instrument;
    },
    band() {
      return this.trackBasicData.band;
    }
	},
	
	methods: {
	}
}
</script>