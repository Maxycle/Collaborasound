<template>
	<Container>
		<div class="w-4/6 flex flex-col items-center h-full">
			<h1 class="bg-zinc-300 border-2 border-zinc-500 p-2 flex justify-center mb-4 rounded-2xl w-fit">
				"{{
					trackBasicData.title
				}}"
			</h1>
			<div ref="conversationContainer" class="overflow-y-auto w-full">
				<div v-for="message in conversationData.messages" :key="message.id" class="mx-6 my-4">
					<div class="flex" :class="{ 'justify-end': message.user_first_name !== firstMessageUserName }">
						<div class="m-1 w-fit border border-zinc-400 p-2 rounded-md shadow-lg shadow-zinc-400"
							:class="bgColor(message)">
							{{ message.content }}
						</div>
					</div>
				</div>
			</div>
			<div class="border-t border-gray-200 p-4 mb-6 w-full">
				<div class="flex">
					<input type="text" :placeholder="placeholder" v-model="myInput"
						class="border border-black rounded p-2 bg-zinc-100 w-full mr-2" />
					<AnarcapButton class="transition hover:scale-110 duration-300" @click="writeMessage">Submit</AnarcapButton>
				</div>
			</div>
		</div>
	</Container>
</template>

<script>

import axios from 'axios'
import TrackCard from '../tracks/TrackCard.vue'
import Container from '../containers/Container.vue'
import AnarcapButton from '../buttons/AnarcapButton.vue'
import { mapGetters } from 'vuex'

export default {
	components: {
		TrackCard,
		Container,
		AnarcapButton
	},
	data() {
		return {
			conversationId: Number(this.$route.params.conversationId),
			conversationData: {},
			myInput: ''
		}
	},

	mounted() {
		this.fetchConversation()
	},

	computed: {
		...mapGetters(['trackBasicData']),
		placeholder() {
			return 'Say something cool mozertrucker !!'
		},

		firstMessageUserName() {
			if (this.conversationData.messages[0]) {
				return this.conversationData.messages[0].user_first_name
			}
		}
	},

	methods: {
		async fetchConversation() {
			try {
				const response = await axios.get(`/api/v1/conversations/${this.conversationId}`)
				this.conversationData = response.data
				this.scrollToBottom()
				console.log('in ze conversation', this.conversationData)
			} catch (error) {
				console.error('Error fetching conversation:', error)
			}
		},

		async writeMessage() {
			try {
				const response = await axios.post(`/api/v1/conversations/${this.conversationId}/messages`, {
					message: {
						content: this.myInput
					}
				})
				this.fetchConversation()
				console.log('conversation posted', response.data)
			} catch (error) {
				console.error('Error posting conversation:', error)
			}
		},

		scrollToBottom() {
			this.$nextTick(() => {
				this.$refs.conversationContainer.scrollTop = this.$refs.conversationContainer.scrollHeight
			})
		},

		bgColor(item) {
			return item.user_first_name !== this.firstMessageUserName ? 'bg-yellow-300' : 'bg-red-300'
		}
	}
}
</script>