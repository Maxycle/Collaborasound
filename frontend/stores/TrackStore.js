import { defineStore } from 'pinia';

export const useStore = defineStore({
  id: 'store',
  state: () => ({
    trackListIds: [],
    myTrackListIds: [],
    trackBasicData: {},
    loggedInUser: undefined
  }),

  actions: {
    async searchTracks({ $axios }, { urlToFetch }) {
      try {
        const response = await $axios.get(urlToFetch);
        const data = response.data;
        if (urlToFetch === '/my_tracks') {
          this.myTrackListIds = data; // Directly mutating state
        } else {
          this.trackListIds = data; // Directly mutating state
          this.loggedInUser = data.logged_in_user; // Directly mutating state
        }
        console.log('Fetched tracks vuex:', data);
        return data;
      } catch (error) {
        console.error('Error fetching tracks:', error);
        throw error;
      }
    },

    setTrackBasicData(data) {
      this.trackBasicData = data; // Directly mutating state
    }
  },

  getters: {
    trackListIds: (state) => state.trackListIds,
    trackBasicData: (state) => state.trackBasicData,
    myTrackListIds: (state) => state.myTrackListIds,
    loggedInUser: (state) => state.loggedInUser
  }
});
