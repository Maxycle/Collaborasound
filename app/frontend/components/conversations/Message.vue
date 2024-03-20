<template>
	<div v-if="!isEditMode">
		<div v-if="!isDeleted" class="m-1 w-fit p-2 rounded-md shadow-lg shadow-zinc-400" :class="bgColor">
			{{ content }}
		</div>
		<div v-else class="m-1 w-fit p-2 rounded-md shadow-lg shadow-zinc-400 text-zinc-500 bg-zinc-300 italic opacity-70">
			Message has beeeen dilitid
		</div>
	</div>
	<div v-else-if="!isDeleted" class="flex items-center bg-inherit space-x-6 m-1 w-fit">
		<input type="text" v-model="myEditedInput" class="rounded-md shadow-lg shadow-zinc-400 bg-green-300 p-4" />
		<AnarcapButton class="transition hover:scale-110 duration-300" @click="updateMessage">Update</AnarcapButton>
	</div>
	<div v-else class="m-1 w-fit p-2 rounded-md shadow-lg shadow-zinc-400 text-zinc-500 bg-zinc-300 italic opacity-70">
			Message has beeeen dilitid
		</div>
</template>

<script>

import axios from 'axios'
import AnarcapButton from '../buttons/AnarcapButton.vue'

export default {
	components: {
		AnarcapButton
	},

	props: {
		content: {
			type: String,
			default: 'du cake à la soupe'
		},

		ids: {
			type: Object,
			default: {}
		},

		isDeleted: {
			type: Boolean,
			default: false
		},

		isEditMode: {
			type: Boolean,
			default: false
		},

		bgColor: {
			type: String,
			default:''
		}
	},

	data() {
		return {
			myEditedInput: this.content
		}
	},

	mounted() {

	},

	computed: {

	},

	methods: {
		async updateMessage() {
			try {
				const response = await axios.patch(`/api/v1/track_conversations/${this.ids.conversation}/messages/${this.ids.message}`, {
					message: {
						content: this.myEditedInput
					}
				})
				this.$emit('message-modified', this.ids.conversation)
				this.myEditedInput = ''
				console.log('conversation posted', response.data)
			} catch (error) {
				console.error('Error posting conversation:', error)
			}
		},
	}
}
</script>