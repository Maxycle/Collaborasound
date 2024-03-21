<template>
	<Container>
		<div class="w-4/6 flex flex-col items-center h-full">
			<h1
				class="bg-zinc-300 border-2 border-zinc-500 p-2 flex justify-center mb-4 rounded-2xl shadow-lg shadow-zinc-400 w-fit">
				"{{
					trackBasicData.title
				}}"
			</h1>
			<div ref="conversationContainer" class="overflow-y-auto w-full">
				<div v-for="(message, index) in conversationData.messages" :key="message.id" class="mx-6 my-4">
					<div class="flex" :class="{ 'justify-end': isRightSideMessage(message) }" @mouseover="onMouseOver(index)"
						@mouseleave="onMouseLeave">
						<div class="flex items-center"
							:class="{ 'flex-row-reverse': message.user_first_name !== firstMessageUserName }">
							<Message :bgColor="bgColor(message)" :ids="{ message: message.id, conversation: conversationId }"
								:isDeleted="message.isDeleted" :content="message.content"
								:is-edit-mode="message.id === messageBeingEditedId" @message-modified="onMessageModified" />
							<div v-show="messageOptionIndex === index && message.user_id === loggedInUser.id" ref="messageOptions"
								class="relative" :class="{ 'right-0': message.user_first_name !== firstMessageUserName }">
								<CloseRound class="w-6 mx-2" @click="toggleMessageOptions(message.user_id)" />
								<div v-show="showOptions" class="absolute -top-6" :class="optionsPositionSide(message)">
									<MessageOptions :ids="{ message: message.id, conversation: conversationId }"
										@edit-message="onEditMessage" @message-modified="this.onMessageModified" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="p-4 mb-6 w-full">
				<div class="flex">
					<input type="text" :placeholder="placeholder" v-model="myInput"
						class="border border-black rounded p-2 bg-zinc-100 w-full mr-2 shadow-lg shadow-zinc-400" />
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
import Message from './Message.vue'
import MessageOptions from './MessageOptions.vue'
import CloseRound from '../svg/CloseRound.vue'
import { mapGetters } from 'vuex'
import { fetchConversation } from '../../helpers/requests.js'

export default {
	components: {
		TrackCard,
		Container,
		AnarcapButton,
		Message,
		MessageOptions,
		CloseRound
	},
	data() {
		return {
			conversationId: Number(this.$route.params.conversationId),
			conversationData: {},
			myInput: '',
			messageOptionIndex: undefined,
			showOptions: false,
			messageBeingEditedId: undefined,
			scroll: true
		}
	},

	mounted() {
		this.fetchCurrentConversation(this.conversationId)
	},

	computed: {
		...mapGetters(['trackBasicData', 'loggedInUser']),
		placeholder() {
			return 'Say something cool mozertrucker !!'
		},

		firstMessageUserName() {
			if (this.conversationData.messages[0]) {
				return this.conversationData.messages[0].user_first_name
			}
		},

		optionsPositionSide() {
			return (message) => {
				return this.isRightSideMessage(message) ? '-start-20' : '-end-20'
			}
		}
	},

	methods: {
		async fetchCurrentConversation(conversationId) {
			this.conversationData = await fetchConversation(conversationId)
			if (this.scroll) { this.scrollToBottom() }
		},

		async writeMessage() {
			try {
				const response = await axios.post(`/api/v1/conversations/${this.conversationId}/messages`, {
					message: {
						content: this.myInput
					}
				})
				this.myInput = ''
				this.fetchCurrentConversation(this.conversationId)
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
		},

		onMouseOver(index) {
			this.messageOptionIndex = index
		},

		toggleMessageOptions(userId) {
			if (this.loggedInUser.id === userId) { this.showOptions = !this.showOptions }
		},

		isRightSideMessage(message) {
			return message.user_first_name !== this.firstMessageUserName
		},

		onMouseLeave() {
			this.showOptions = false
		},

		onEditMessage(messageId) {
			this.messageBeingEditedId = messageId.message
		},

		async onMessageModified(conversationId) {
			this.scroll = false
			await this.fetchCurrentConversation(conversationId)
			this.messageBeingEditedId = undefined
			this.scroll = true
		}
	}
}
</script>