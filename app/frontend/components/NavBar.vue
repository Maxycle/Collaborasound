<template>
	<div class="flex justify-end space-x-2 bg-blue-300 pr-4">
		<button :class="{ 'bg-blue-600': activeButton === 'home' }"
			class="p-2 hover:bg-red-400 transition-colors duration-300 hover:font-bold rounded-full"><router-link to="/"
				@click="setActiveButton('home')">home</router-link></button>
		<button :class="{ 'bg-blue-600': activeButton === 'myTracks' }"
			class="p-2 hover:bg-red-400 transition-colors duration-300 hover:font-bold rounded-full"><router-link
				to="/my_own_tracks" @click="setActiveButton('myTracks')">My tracks</router-link></button>
		<button class="p-2 hover:bg-red-400 transition-colors duration-300 hover:font-bold rounded-full"
			@click="redirectToEditProfile">Edit profile</button>
		<button class="p-2 hover:bg-red-400 transition-colors duration-300 hover:font-bold rounded-full"
			@click="logout">Logout</button>
	</div>
</template>

<script>

import axios from 'axios'

export default {
	data() {
		return {
			activeButton: ''
		}
	},

	mounted() {
		this.setActiveButton(this.$route.path);
	},

	computed: {
		setActiveButton() {
			return (routePath) => {
				switch (routePath) {
					case '/':
						this.activeButton = 'home';
						break;
					case '/my_own_tracks':
						this.activeButton = 'myTracks';
						break;
					case '/users/edit':
						this.activeButton = 'editProfile';
						break;
					default:
						this.activeButton = '';
				}
			}
		}
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