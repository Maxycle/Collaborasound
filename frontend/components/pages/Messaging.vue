<template>
	<Container class="overflow-y-auto">
		<div class="flex space-x-8">
			<NavBarButton :isActive="activeList === 'IN'" @click="activate('IN')">
				<span class="relative">Inbox</span>
			</NavBarButton>
			<NavBarButton :isActive="activeList === 'OUT'" @click="activate('OUT')">
				<span class="relative">Outbox</span>
			</NavBarButton>
			<NavBarButton :isActive="activeList === 'write'" @click="activate('write')">
				<span class="relative">Start a new conversation</span>
			</NavBarButton>
		</div>
		<div v-if="activeList === 'write'" class="w-4/5">
			<NewConversation class="" />
		</div>
		<ConversationsTable v-else :isInbox="activeList === 'IN'" class="mt-8" />
	</Container>
</template>

<script>

import NavBarButton from '../buttons/NavBarButton.vue'
import ConversationsTable from '../conversations/ConversationsTable.vue'
import Container from '../containers/Container.vue'
import NewConversation from '../conversations/NewConversation.vue'

export default {
	components: {
		NavBarButton,
		ConversationsTable,
		Container,
		NewConversation
	},

	props: {
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
			default: ''
		}
	},

	data() {
		return {
			activeList: 'IN'
		}
	},

	methods: {
		activate(string) {
			this.activeList = string
		}
	}
}
</script>