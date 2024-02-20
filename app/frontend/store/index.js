import { createStore } from 'vuex';

export default createStore({
  state: {
    trackListIds: [],
    trackBasicData: {}
  },
  
  mutations: {
    setTracksIds(state, data) {
        state.trackListIds = data;
      },
      setTrackBasicData(state, data) {
        state.trackBasicData = data;
      },
  },

  actions: {
    async searchTracks({ commit }, { axios, urlToFetch }) {
      try {
        const response = await axios.get(urlToFetch);
        commit('setTracksIds', response.data);
        console.log('Fetched tracks:', response.data);
        return response.data;
      } catch (error) {
        console.error('Error fetching tracks:', error);
        throw error; // Re-throw the error to handle it in the component
      }
    },
    storeTrackBasicData({ commit }, data ) {
      commit('setTrackBasicData', data)
    }
  },

  getters: {
    trackListIds(state) {
        return state.trackListIds;
      },
    trackBasicData(state) {
      return state.trackBasicData
    }
  }
})
