<template>
	<div class="relative isolate w-full">
		<img src="/home/maxycle/code/Collaborasound/app/assets/images/Flag_of_Anarcho-capitalism.svg.png" alt=""
			class="absolute inset-0 -z-10 h-full w-full object-fill md:object-center rounded-2xl" />
		<div class="p-4 rounded-2xl shadow-lg shadow-stone-400">
			<div class="flex justify-center pb-2">
				<div class="max-w-fit rounded bg-lime-100 border border-green-600 p-2">
					<p class="font-bold text-2xl flex justify-center">"{{ trackData.title }}"</p>
					<div class="text-lg">{{ headers.origin }} &nbsp;<span class="font-bold">{{ trackData.author }}</span></div>
				</div>
			</div>
			<div class="flex items-center justify-between">
				<div v-if="trackData && trackData.music_genres && trackData.music_genres.length">
					<p class="text-center mx-2">Music style</p>
					<div v-for="genre in trackData.music_genres" :key="genre.name" class="flex items-center justify-center">
						<ParamButton :heading="genre.name" />
					</div>
				</div>
				<div class="bg-lime-100 border border-green-600 rounded h-10 p-2 flex items-center justify-center w-1/4">
					<div class="">listen</div>
				</div>
				<button class="bg-lime-100 border border-green-600 rounded h-10 p-2 flex items-center justify-center w-1/4">
					<div v-if="!trackData.isResult">
						<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">
							<p>Track id: {{ trackId }}</p>
						</router-link>
					</div>
					<div v-else>See what people say {{ trackId }}</div>
				</button>
				<div v-if="trackData && trackData.instruments && trackData.instruments.length">
					<p class="text-center text-white">{{ headers.instruments }}</p>
					<div v-for="instrument in trackData.instruments" :key="instrument.name"
						class="flex items-center justify-center">
						<ParamButton :heading="instrument.name" />
					</div>
				</div>
			</div>
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
			trackData: {},
			instrumentHeader: ''
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

	computed: {
		headers() {
			return this.trackData.isResult ? { instruments: `${this.instrumentHeader} added`, origin: 'instrument(s) added by' } : { instruments: `${this.instrumentHeader} needed`, origin: 'from' }
		}
	},

	methods: {
		async fetchTrackDetails() {
			try {
				const response = await axios.get(`/tracks/${this.trackId}`)
				this.trackData = response.data
				this.instrumentHeader = this.trackData.instruments.length > 1 ? 'Instruments' : 'Instrument'
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

<style>
.bg-svg-container {
	background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><polygon points="0,100 100,0 100,100" fill="yellow" /><polygon points="0,0 0,100 100,0" fill="black" /></svg>');
}
</style>