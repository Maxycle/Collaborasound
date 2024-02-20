<template>
  <Container>
    <TracksList />
  </Container>
</template>
  
<script>
import Hero from './Hero.vue'
import Container from '../containers/Container.vue'
import TracksList from '../tracks/TracksList.vue'

export default {
  components: {
    Hero,
    Container,
    TracksList
},

  data() {
    return {
      tracks: []
    };
  }
}
</script>
  