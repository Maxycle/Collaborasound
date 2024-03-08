<template>
	<div class="w-4/5">
		<div
			class="flex items-center justify-center w-full p-4">
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

<script>
import TrackCard from './TrackCard.vue'
import { mapGetters } from 'vuex';
import axios from 'axios'

export default {
	components: {
		TrackCard
	},
	props: {
		isResult: {
			type: Boolean,
			default: false
		},
		isMyTracks: {
			type: Boolean,
			default: false
		},
		trackId: {
			type: Number,
			default: undefined
		}
	},
	data() {
		return {
			childrenIds: []
		};
	},
	computed: {
		...mapGetters(['trackListIds', 'myTrackListIds']),

		currentTrackList() {
			if (!this.isResult && !this.isMyTracks) {
				return this.trackListIds;
			} else if (!this.isResult && this.isMyTracks) {
				return this.myTrackListIds;
			} else {
				return this.childrenIds;
			}
		}
	},
	mounted() {
		if (this.trackId) { this.fetchTrackChildrenIds() }
	},

	methods: {
		async fetchTrackChildrenIds() {
			try {
				const response = await axios.get(`/index_results/${this.trackId}`)
				this.childrenIds = response.data
			} catch (error) {
				console.error('Error fetching tracks:', error)
			}
		}
	}
}
</script>