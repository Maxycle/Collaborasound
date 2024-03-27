<template>
	<div class="w-full border border-black p-2 rounded-xl bg-green-300">
		<div class="flex">
			<p>To: </p>
			<Autocomplete heading='Receiver' />
		</div>
	</div>
</template>

<script>

import NavBarButton from '../buttons/NavBarButton.vue'
import Container from '../containers/Container.vue'
import Autocomplete from '../search/Autocomplete.vue'

export default {
	components: {
		NavBarButton,
		Container,
		Autocomplete
	},

	props: {

	},

	data() {
		return {
			activeList: 'IN'
		}
	},

	methods: {

	}
}
</script>