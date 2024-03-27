<template>
  <div class="flex justify-between px-4 items-center bg-zinc-200 shadow-lg shadow-stone-400">
    <div>Hello {{ loggedInUser.first_name }} you muzzafucka !!</div>
    <div class="flex justify-end space-x-2">
      <NavBarButton :isActive="isRouteActive('/')">
        <span class="relative"><router-link to="/">Home</router-link></span>
      </NavBarButton>
      <NavBarButton :isActive="isRouteActive('/my_own_tracks')">
        <span class="relative"><router-link to="/my_own_tracks">My tracks</router-link></span>
      </NavBarButton>
      <NavBarButton :isActive="isRouteActive('/my_messages')">
        <span class="relative"><router-link to="/my_messages">My messages</router-link></span>
      </NavBarButton>
      <NavBarButton @click="redirectToEditProfile">
        <span class="relative">Edit profile</span>
      </NavBarButton>
      <NavBarButton @click="logout">
        <span class="relative">Logout</span>
      </NavBarButton>  
    </div>
  </div>
</template>

<script setup>
import axios from 'axios';
import NavBarButton from './buttons/NavBarButton.vue';
import { useRoute } from 'vue-router';
import { useStore } from 'pinia';

const store = useStore();
const route = useRoute();

const loggedInUser = computed(() => store.getters.loggedInUser);

const isRouteActive = (path) => {
  return route.path === path;
};

const logout = async () => {
  try {
    await axios.delete('/users/sign_out');
    window.location.href = '/';
  } catch (error) {
    console.error('Error logging out', error);
  }
};

const redirectToEditProfile = () => {
  window.location.href = '/users/edit';
};
</script>
