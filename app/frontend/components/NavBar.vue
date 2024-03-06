<template>
	<div class="flex justify-end space-x-2 bg-zinc-300 pr-4">
		<button :class="{ 'bg-zinc-200': activeButton === 'home' }"
			class="p-2 hover:bg-anarcapYellow transition-colors duration-300 hover:font-bold rounded"><router-link to="/"
				@click="setActiveButton('/')">home</router-link></button>
		<button :class="{ 'bg-zinc-200': activeButton === 'myTracks' }"
			class="p-2 hover:bg-anarcapYellow transition-colors duration-300 hover:font-bold rounded"><router-link
				to="/my_own_tracks" @click="setActiveButton('/my_own_tracks')">My tracks</router-link></button>
		<button class="p-2 hover:bg-anarcapYellow transition-colors duration-300 hover:font-bold rounded"
			@click="redirectToEditProfile">Edit profile</button>
		<button class="p-2 hover:bg-anarcapYellow transition-colors duration-300 hover:font-bold rounded"
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