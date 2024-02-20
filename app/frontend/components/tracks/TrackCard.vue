<template>
	<div class="bg-green-300 border-2 border-green-600  w-1/2 rounded-2xl p-4 flex justify-between items-center">
		<div class="w-1/3">
			<p>Track id: {{ trackId }}</p>
			<p>The title: {{ trackData.title }}</p>
			<p>Ze author: {{ trackData.author }}</p>
			<p>Ze instrument wanted: {{ trackData.instrument }}</p>
			<p>Ze genre: {{ trackData.music_genre }}</p>
			<p>Ze band: {{ trackData.band }}</p>
			<p>Izit a rezult: {{ trackData.isResult }}</p>
		</div>
		<div class="bg-blue-200 border-2 border-green-600 rounded-2xl h-10 p-2 flex items-center justify-center w-1/4">
			<div class="">listen</div>
		</div>
		<div class="bg-blue-200 border-2 border-green-600 rounded-2xl h-10 p-2 flex items-center justify-center w-1/4">
			<div v-if="!trackData.isResult">
				<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">go to ze
					track</router-link>
			</div>
			<div v-else>See what people say</div>
		</div>
	</div>
</template>

<script>
import axios from 'axios'

export default {
	props: {
		trackId: {
			type: Number,
			default: undefined
		}
	},

	data() {
		return {
			trackData: {}
		};
	},

	watch: {
		trackId(newValue, oldValue) {
			this.fetchTrackDetails(newValue)
		}
	},

	mounted() {
		this.fetchTrackDetails(this.trackId)
	},

	methods: {
		async fetchTrackDetails() {
			try {
				// Make an HTTP request to fetch options based on the heading
				const response = await axios.get(`/tracks/${this.trackId}`);
				this.trackData = response.data; // Update options with the fetched data
				console.log('in ze track', this.trackData)
			} catch (error) {
				console.error('Error fetching tracks:', error);
			}
		},
		sendTrackDetailsToVuex() {
			this.$store.dispatch('storeTrackBasicData', this.trackData)
		}
	}
}
</script>