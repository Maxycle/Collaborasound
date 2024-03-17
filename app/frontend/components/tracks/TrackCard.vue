<template>
	<div class="relative isolate w-full">
		<img src="../../../Flag_of_Anarcho-capitalism.png" alt=""
			class="absolute inset-0 -z-10 h-full w-full object-fill md:object-center rounded-2xl border border-zinc-600" />
		<div v-if="trackData && trackData.children && trackData.children.length > 0"
			class="absolute top-2 right-2 bg-anarcapYellow rounded">
			<div class="border-b-4 border-anarcapYellow bg-anarcapYellow rounded-xl">
				<div class="bg-orange-300 rounded p-1 transition shadow-md shadow-black hover:scale-110 duration-300">
					<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">
						has {{
			trackData.children.length }} collaborasound<span v-if="trackData.children.length > 1">s</span>
					</router-link>
				</div>
			</div>
		</div>
		<div v-if="trackData && trackData.isResult && !isTrackPage"
			class="absolute top-2 right-2 bg-anarcapYellow border border-anarcapYellow rounded">
			<div class="bg-green-500 p-1 border border-green-600 rounded">My collaborasound</div>
		</div>
		<div class="p-4 rounded-2xl shadow-lg shadow-zinc-600">
			<div class="flex justify-center pb-2">
				<div class="border-b-4 border-anarcapYellow bg-anarcapYellow rounded-xl">
					<div class="max-w-fit rounded-xl bg-lime-100 border border-black p-2 shadow-md shadow-black">
						<p v-if="trackData && !isTrackPage" class="font-bold text-2xl flex justify-center">"{{
			trackData.title
		}}"</p>
						<div v-if="!isMyOwnTracksPage" class="text-lg">{{ headers.origin }}<span class="font-bold">{{
			trackData.author ?
				trackData.author.first_name : 'Unknown' }}</span></div>
					</div>
				</div>
			</div>
			<div class="flex items-center justify-between">
				<div :class="{ 'invisible': trackData && trackData.music_genres && !trackData.music_genres.length }">
					<p class="text-center mx-2 font-bold">Music style</p>
					<div v-for="genre in trackData.music_genres" :key="genre.name" class="">
						<div class="border border-b-anarcapYellow bg-anarcapYellow rounded-full">
							<ParamButton :heading="genre.name" color='blue' class="rounded-full shadow-md shadow-black" />
						</div>
					</div>
				</div>
				<button
					class="shadow-md shadow-black outline outline-blue-400 outline-2 outline-offset-2 bg-lime-100 border border-black transition hover:translate-x-6 hover:scale-110 duration-300 rounded-xl h-10 w-1/4 flex items-center justify-center">
					listen
				</button>

				<button v-if="trackData && !trackData.isResult"
					class="outline outline-blue-400 outline-2 outline-offset-2 bg-lime-100 border border-black transition hover:-translate-x-6 hover:scale-110 duration-300 rounded-xl h-10 w-1/4 flex items-center justify-center">
					<router-link :to="{ name: 'track', params: { zeTrackId: trackId } }" @click="sendTrackDetailsToVuex">
						{{ isMyOwnTracksPage ? 'Go to my track page' : 'Collaborate' }} {{ trackId }}
					</router-link>
				</button>
				<button v-else
					class="outline outline-blue-400 outline-2 outline-offset-2 bg-lime-100 border border-black transition hover:-translate-x-6 hover:scale-110 duration-300 rounded-xl h-10 w-1/4 flex items-center justify-center"
					:class="{ 'hidden': doNotshowSeeConversationButton }" @click="goToConversation">See the conversation {{ trackId }}
				</button>

				<div :class="{ 'invisible': trackData && trackData.instruments && !trackData.instruments.length }">
					<p class="text-center text-white font-bold">{{ headers.instruments }}</p>
					<div v-for="instrument in trackData.instruments" :key="instrument.name">
						<div class="border border-black rounded-full">
							<ParamButton :heading="instrument.name" color="blue" border-color="blue" class="rounded-full" />
						</div>
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
import { nextTick } from 'vue'

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
			instrumentHeader: 'cul'
		};
	},

	watch: {
		trackId(newValue, oldValue) {
			this.fetchTrackDetails()
		}
	},

	mounted() {
		this.fetchTrackDetails()
	},

	computed: {
		headers() {
			return this.trackData.isResult ? { instruments: `${this.instrumentHeader} added`, origin: 'instrument(s) added by' } : { instruments: `${this.instrumentHeader} needed`, origin: 'from' }
		},

		isTrackPage() {
			return this.$route.path === `/track/${this.parentTrackId}`
		},

		isMyOwnTracksPage() {
			return this.$route.path === '/my_own_tracks'
		},

		doNotshowSeeConversationButton() {
			if (this.trackData.author) {
				return this.isTrackPage && !this.trackData.isMyProject && (this.trackData.logged_in_user_id !== this.trackData.author.id)
			}
		},


	},

	methods: {
		async fetchTrackDetails() {
			try {
				const response = await axios.get(`/tracks/${this.trackId}`)
				this.trackData = response.data
				this.instrumentHeader = this.trackData.instruments.length > 1 ? 'Instruments' : 'Instrument'
				await nextTick()
			} catch (error) {
				console.error('Error fetching tracks:', error)
			}
		},
		sendTrackDetailsToVuex() {
			this.$store.dispatch('storeTrackBasicData', this.trackData)
		},

		goToConversation() {
			this.sendTrackDetailsToVuex()
			if (this.trackData.isResult && !this.trackData.has_conversation) {
				this.createConversation()
			} else if (this.trackData.isResult && this.trackData.has_conversation) {
				router.push(`/conversation/${this.trackData.conversation_id}`)
			}
		},

		async createConversation() {
			try {
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
