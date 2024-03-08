<template>
	<Container>
		<div class="w-4/5">
			<div class="pb-4"><span class="font-bold">{{ author }}</span> needs some <span class="font-bold">{{ instrument ||
				'stuff' }}</span> to make some <span class="font-bold">{{ genre || 'weird' }}</span> muzik for the song :</div>
			<h1 class="flex justify-center pb-4"> "{{ trackTitle }}""</h1>
			<div class="flex justify-center space-x-4 pb-4">
				<AnarcapButton class="transition hover:text-red-500 hover:font-extrabold hover:-translate-y-1 hover:scale-110 duration-300"><span class="relative">listen to "{{ trackTitle
				}}"</span></AnarcapButton>
				<AnarcapButton class="transition hover:text-red-500 hover:font-extrabold hover:-translate-y-1 hover:scale-110 duration-300"><span class="relative">download "{{ trackTitle
				}}""</span></AnarcapButton>
				<AnarcapButton class="transition hover:text-red-500 hover:font-extrabold hover:-translate-y-1 hover:scale-110 duration-300"><span class="relative"><router-link
							:to="{ name: 'result_track', params: { zeTrackId: trackId } }">upload your
							track/result</router-link></span></AnarcapButton>
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
import AnarcapButton from '../buttons/AnarcapButton.vue'
import { mapGetters } from 'vuex'

export default {
	components: {
		Container,
		TracksList,
		AnarcapButton
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
			return this.trackBasicData.author.first_name
		},
		instrument() {
			return this.trackBasicData.instruments.map(item => item.name).join('/')
		},
		band() {
			return this.trackBasicData.band
		},
		trackTitle() {
			return this.trackBasicData.title
		}
	},

	methods: {
	}
}
</script>