<template>
	<div class="border border-black rounded-md shadow-lg shadow-zinc-400">
		<div class="p-2 rounded-t-md hover:bg-zinc-300" @click="deleteMessage">Delete</div>
		<div class="p-2 rounded-b-md hover:bg-zinc-300" @click="editMessage">Edit</div>
	</div>
</template>

<script>
import axios from 'axios'

export default {
	props: {
		content: {
			type: String,
			default: 'du cake à la soupe'
		},

		ids: {
			type: Object,
			default: {}
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
		async deleteMessage() {
			try {
				const response = await axios.patch(`/api/v1/track_conversations/${this.ids.conversation}/messages/${this.ids.message}`, {
					message: {
						deleted: true
					}
				})
				this.$emit('message-modified', this.ids.conversation)
			} catch (error) {
				console.error('Error deleting message:', error)
			}
		},

		editMessage() {
			this.$emit('edit-message', this.ids)
		}
	}
}
</script>