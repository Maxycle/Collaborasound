<template>
	<div class="w-4/5">
		<div
			class="bg-orange-300 border-2 border-green-600 rounded-2xl flex items-center justify-center space-y-4 w-full p-4">
			<div class="w-4/5">
				<div v-if="!isResult">
					<div v-for="track in trackListIds" :key="track.title" class="">
						<TrackCard :trackId="track.id" class="w-full my-2" />
					</div>
				</div>
				<div v-else>
					<div v-for="track in childrenIds" :key="track.title" class="">
						<TrackCard :trackId="track.id" class="w-full my-2" />
					</div>
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
		// Map the 'numberOfTracks' getter to the component's computed properties
		...mapGetters(['trackListIds'])
	},
	mounted() {
		if (this.trackId) {this.fetchTrackChildrenIds()}
	},	

	methods: {
		async fetchTrackChildrenIds() {
			try {
				// Make an HTTP request to fetch options based on the heading
				const response = await axios.get(`/index_results/${this.trackId}`);
				this.childrenIds = response.data; // Update options with the fetched data
			} catch (error) {
				console.error('Error fetching tracks:', error);
			}
		}
	}
}
</script>