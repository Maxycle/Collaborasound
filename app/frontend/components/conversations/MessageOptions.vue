<template>
	<div class="border border-black rounded-md shadow-lg shadow-zinc-400">
		<div class="p-2 rounded-t-md hover:bg-zinc-300">Delete</div>
		<div class="p-2 rounded-b-md hover:bg-zinc-300">Edit</div>
	</div>
</template>

<script>

import axios from 'axios'

export default {
	props: {
		content: {
			type: String,
			default: 'du cake à la soupe'
		}
	},

	data() {
		return {
			activeButton: ''
		}
	},

	mounted() {

	},

	computed: {

	},

	methods: {

	}
}
</script>