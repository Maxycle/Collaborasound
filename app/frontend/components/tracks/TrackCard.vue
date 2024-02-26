<template>
	<div class="bg-green-300 border-2 border-green-600  w-1/2 rounded-2xl p-4 flex justify-between items-center">
		<div class="w-1/3 flex">
			<div>
				<p>The title: {{ trackData.title }}</p>
				<p>Ze author: {{ trackData.author }}</p>
				<p>Ze band: {{ trackData.band }}</p>
			</div>
			<div>
				<p class="flex items-center justify-center mx-2">Music style</p>
				<div v-for="genre in trackData.music_genres" :key="genre.name" class="flex items-center justify-center">
					<ParamButton :heading="genre.name" />
				</div>
			</div>
			<div>
				<p class="flex items-center justify-center">Instruments</p>
				<div v-for="instrument in trackData.instruments" :key="instrument.name" class="flex items-center justify-center">
					<ParamButton :heading="instrument.name" color="red" />
				</div>
			</div>
		</div>
		<div class="bg-blue-200 border-2 border-green-600 rounded-2xl h-10 p-2 flex items-center justify-center w-1/4">
			<div class="">listen</div>
		</div>
		<div class="bg-blue-200 border-2 border-green-600 rounded-2xl h-10 p-2 flex items-center justify-center w-1/4">
			<div v-if="!trackData.isResult">
				<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">
					<p>Track id: {{ trackId }}</p>
				</router-link>
			</div>
			<div v-else>See what people say {{ trackId }}</div>
		</div>
	</div>
</template>

<script>
import axios from 'axios'
import ParamButton from '../buttons/ParamButton.vue'

export default {
	components: {
		ParamButton
	},
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
				const response = await axios.get(`/tracks/${this.trackId}`)
				this.trackData = response.data
				console.log('in ze track', this.trackData)
			} catch (error) {
				console.error('Error fetching tracks:', error)
			}
		},
		sendTrackDetailsToVuex() {
			this.$store.dispatch('storeTrackBasicData', this.trackData)
		}
	}
}
</script>