<template>
	<Hero />
	<router-view></router-view>
</template>

<script>
import Hero from './Hero.vue'

export default {
	components: {
		Hero
	}
}
</script>