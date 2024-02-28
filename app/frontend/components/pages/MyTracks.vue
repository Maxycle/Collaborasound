<template>
	<Container>
		<TracksList isMyTracks/>
	</Container>
</template>

<script>
import Container from '../containers/Container.vue'
import TracksList from '../tracks/TracksList.vue'

export default {
	components: {
		Container,
		TracksList
	}
}
</script>