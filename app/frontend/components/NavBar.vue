<template>
	<div class="flex justify-end space-x-2 bg-zinc-300 pr-4">
		<NavBarButton :isActive="activeButton === 'home'" class="">
			<span class="relative"><router-link to="/" @click="setActiveButton('/')">home</router-link></span>
		</NavBarButton>
		<NavBarButton :isActive="activeButton === 'myTracks'">
			<span class="relative"><router-link to="/my_own_tracks" @click="setActiveButton('/my_own_tracks')">My
					tracks</router-link></span>
		</NavBarButton>
		<NavBarButton @click="redirectToEditProfile">
			<span class="relative"><router-link to="/">Edit profile</router-link></span>
		</NavBarButton>
		<NavBarButton @click="logout">
			<span class="relative"><router-link to="/">Logout</router-link></span>
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