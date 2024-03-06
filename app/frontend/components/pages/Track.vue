<template>
	<Container>
		<div class="w-4/5">
			<div class="pb-4"><span class="font-bold">{{ author }}</span> needs some <span class="font-bold">{{ instrument || 'stuff'}}</span> to make some <span class="font-bold">{{ genre || 'weird' }}</span> muzik.</div>
			<div class="flex justify-center space-x-4 pb-4">
				<div class="bg-black text-white rounded-xl shadow-lg shadow-stone-400 p-4">listen to ze Track</div>
				<div class="bg-black text-white rounded-xl shadow-lg shadow-stone-400 p-4">download ze track</div>
				<div class="bg-black text-white rounded-xl shadow-lg shadow-stone-400 p-4"><router-link
						:to="{ name: 'result_track', params: { zeTrackId: trackId } }">upload your track/result</router-link></div>
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
import { mapGetters } from 'vuex'

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
			return this.trackBasicData.music_genres.map(item => item.name).join('/')
		},
		author() {
			return this.trackBasicData.author;
		},
		instrument() {
			return this.trackBasicData.instruments.map(item => item.name).join('/')
		},
		band() {
			return this.trackBasicData.band;
		}
	},

	methods: {
	}
}
</script>