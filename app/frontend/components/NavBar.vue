<template>
	<div class="flex justify-end space-x-2 bg-zinc-200 pr-4 shadow-lg shadow-stone-400">
		<NavBarButton :isActive="$route.path === '/'">
			<span class="relative"><router-link to="/">Home</router-link></span>
		</NavBarButton>
		<NavBarButton :isActive="$route.path === '/my_own_tracks'">
			<span class="relative"><router-link to="/my_own_tracks">My tracks</router-link></span>
		</NavBarButton>
		<NavBarButton @click="redirectToEditProfile">
			<span class="relative">Edit profile</span>
		</NavBarButton>
		<NavBarButton @click="logout">
			<span class="relative">Logout</span>
		</NavBarButton>
	</div>
</template>

<script>
import axios from 'axios'
import NavBarButton from './buttons/NavBarButton.vue'

export default {
	components: {
		NavBarButton
	},

	methods: {
		async logout() {
			try {
				await axios.delete('/users/sign_out')
				window.location.href = '/'
			} catch (error) {
				console.error('Error logging out', error)
			}
		},
		redirectToEditProfile() {
			window.location.href = '/users/edit'
		}
	}
}
</script>
