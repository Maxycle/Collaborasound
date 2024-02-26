<template>
	<button class="flex justify-center min-w-16 border-2 
		border-green-500 text-xs m-1 hover:bg-blue-700 text-white py-2 px-2 rounded-full" :class="bgColor">
		{{ heading }}
		<div v-if="removable">
			<CloseRound class="ml-2 w-4" @click="kruigh" />
		</div>
	</button>
</template>

<script>
import CloseRound from '../svg/CloseRound.vue'

export default {
	components: {
		CloseRound
	},

	props: {
		heading: {
			type: String,
			default: 'ta mère en short',
		},
		color: {
			type: String,
			default: 'yellow'
		},
		removable: {
			type: Boolean,
			default: false
		}
	},

	data() {
		return {

		}
	},

	computed: {
		bgColor() {
			switch (this.color) {
				case 'yellow':
					return 'bg-yellow-400'
					break;
				case 'red':
					return 'bg-red-400'
					break;
				case 'blue':
					return 'bg-blue-400'
					break;
			}
		}
	},

	methods: {
		kruigh() {
			this.$emit('removedd', this.heading)
		}
	}
}
</script>