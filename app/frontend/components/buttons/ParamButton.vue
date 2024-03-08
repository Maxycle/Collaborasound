<template>
	<button class="flex justify-center min-w-16 border border-green-600 text-xs m-1 hover:bg-blue-700 py-2 px-2 rounded"
		:class="bgColor">
		{{ heading }}
		<div v-if="removable">
			<CloseRound class="ml-2 w-4" @click="remove" />
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
			default: 'lime'
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
					return 'bg-orange-300'
					break;
				case 'blue':
					return 'bg-teal-300'
					break;
				case 'grey':
					return 'bg-slate-400'
					break;
				case 'lime':
					return 'bg-lime-100'
					break;
			}
		}
	},

	methods: {
		remove() {
			this.$emit('removedd', this.heading)
		}
	}
}
</script>