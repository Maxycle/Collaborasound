<template>
	<NavBar />
	<div class="w-full">
		<div class="flex flex-col items-center py-4 bg-orange-100">
			<button v-if="!isModalOpen" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mb-2"
				@click="openModal">{{ mapButtonText }}</button>
			<button v-else class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mb-2"
				@click="closeModal">{{ mapButtonText }}</button>
			<div v-if="isModalOpen" class="w-4/6 mb-2">
				<div class="">
					<button class="close" @click="closeModal">&times;</button>
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
		openModal() {
			this.isModalOpen = true;
		},
		closeModal() {
			this.isModalOpen = false;
		}
	}
}
</script>