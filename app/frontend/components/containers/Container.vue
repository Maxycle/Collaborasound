<template>
	<NavBar />
	<div class="w-full">
		<div class="flex flex-col items-center py-4 bg-zinc-200">
			<button v-if="$route.path === '/'" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mb-2"
				@click="toggleModal">{{ mapButtonText }}</button>
			<div v-if="isModalOpen" class="w-4/6 transition ease-in-out duration-1000 opacity-100 mb-2">
				<div class="">
					<Map class="w-full" />
				</div>
			</div>
			<slot />
		</div>
	</div>
</template>

<script>
import NavBar from '../NavBar.vue'
import Map from '../map/Map.vue'
export default {
	components: {
		NavBar,
		Map
	},

	data() {
		return {
			isModalOpen: false
		};
	},
	computed: {
		mapButtonText() {
			return this.isModalOpen ? 'Close da muzzakuckin map' : 'See on da muzzakuckin map'
		}
	},

	methods: {
		toggleModal() {
			this.isModalOpen = !this.isModalOpen
		}
	}
}
</script>