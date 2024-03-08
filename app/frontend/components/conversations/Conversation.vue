<template>
	<Container>
		<h1 class="bg-red-500">Ze conversation !! {{ this.conversationData.music_track_parent }}</h1>
		<!-- <TrackCard :trackId="zeTrackId" class="w-1/2"/> -->
	</Container>
</template>

<script>

import axios from 'axios'
import TrackCard from '../tracks/TrackCard.vue'
import Container from '../containers/Container.vue'

export default {
	components: {
		TrackCard,
		Container
	},
	data() {
		return {
			conversationId: Number(this.$route.params.conversationId),
			conversationData: {}
		}
	},

	mounted() {
		this.fetchConversation()
	},

	methods: {
		async fetchConversation() {
			try {
				const response = await axios.get(`/api/v1/conversations/${this.conversationId}`)
				this.conversationData = response.data
				console.log('in ze conversation', this.conversationData)
			} catch (error) {
				console.error('Error fetching tracks:', error)
			}
		},
	}
}
</script> /api/v1/conversations/by_track/:trackId(.:format)  