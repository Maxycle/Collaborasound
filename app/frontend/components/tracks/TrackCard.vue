<template>
	<div class="relative isolate w-full">
		<img src="/home/maxycle/code/Collaborasound/app/assets/images/Flag_of_Anarcho-capitalism.svg.png" alt=""
			class="absolute inset-0 -z-10 h-full w-full object-fill md:object-center rounded-2xl" />
		<div v-if="trackData.children && trackData.children.length > 0"
			class="absolute top-2 right-2 bg-anarcapYellow border border-anarcapYellow rounded">
			<div class="bg-orange-300 border border-black rounded p-1">
				<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">
					has {{
						trackData.children.length }} collaborasound<span v-if="trackData.children.length > 1">s</span>
				</router-link>
			</div>
		</div>
		<div v-if="trackData.isResult && isNotTrackPage"
			class="absolute top-2 right-2 bg-green-500 p-1 border border-green-600 rounded"> collaborasounded
		</div>
		<div class="p-4 rounded-2xl shadow-lg shadow-stone-400">
			<div class="flex justify-center pb-2">
				<div class="border border-anarcapYellow bg-anarcapYellow rounded">
					<div class="max-w-fit rounded bg-lime-100 border border-black p-2">
						<p v-if="isNotTrackPage" class="font-bold text-2xl flex justify-center">"{{ trackData.title }}"</p>
						<div v-if="showSubTitle" class="text-lg">{{ headers.origin }}&nbsp;<span class="font-bold">{{
							trackData.author ?
							trackData.author.first_name : 'Unknown' }}</span></div>
					</div>
				</div>
			</div>
			<div class="flex items-center justify-between">
				<div :class="{ 'invisible': trackData && trackData.music_genres && !trackData.music_genres.length }">
					<p class="text-center mx-2 font-bold">Music style</p>
					<div v-for="genre in trackData.music_genres" :key="genre.name"
						class="">
						<ParamButton :heading="genre.name" color='blue' class="rounded-full" />
					</div>
				</div>
				<div class="border border-anarcapYellow bg-anarcapYellow rounded h-10 w-1/4">
					<div class="bg-lime-100 border border-black rounded h-full w-full flex items-center justify-center">
						<div class="">listen</div>
					</div>
				</div>
				<div class="border border-anarcapYellow bg-anarcapYellow rounded h-10 w-1/4">
					<button class="bg-lime-100 border border-black rounded h-full w-full flex items-center justify-center">
						<div v-if="!trackData.isResult">
							<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">
								<p>Track id: {{ trackId }}</p>
							</router-link>
						</div>

						<div v-else @click="sendTrackDetailsToVuex">See the conversation {{ trackId }}</div>
					</button>
				</div>
				<div :class="{ 'invisible': trackData && trackData.instruments && !trackData.instruments.length }">
					<p class="text-center text-white font-bold">{{ headers.instruments }}</p>
					<div v-for="instrument in trackData.instruments" :key="instrument.name"
						class="">
						<ParamButton :heading="instrument.name" color="blue" border-color='anarcapYellow' class="rounded-full"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import axios from 'axios'
import ParamButton from '../buttons/ParamButton.vue'
import router from '../../entrypoints/router.js'

export default {
	components: {
		ParamButton
	},
	props: {
		trackId: {
			type: Number,
			default: undefined
		},

		parentTrackId: {
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
		},

		isNotTrackPage() {
			return this.$route.path !== `/track/${this.parentTrackId}`
		},

		showSubTitle() {
			return this.$route.path !== '/my_own_tracks'
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
			if (this.trackData.isResult && !this.trackData.has_conversation) {
				this.createConversation()
			} else if (this.trackData.isResult && this.trackData.has_conversation) {
				router.push(`/conversation/${this.trackData.conversation_id}`)
			}
		},

		async createConversation() {
			try {
				// If no conversation exists, create a new conversation
				const newConversationResponse = await axios.post('/api/v1/conversations', {
					conversation: {
						music_track_id: this.trackId
					}
				})
				console.log('New conversation created:', newConversationResponse.data);
				router.push(`/conversation/${newConversationResponse.data.id}`)
			} catch (error) {
				console.error('Error creating or fetching conversation:', error);
			}
		}
	}
}
</script>
