import { createStore } from 'vuex';

export default createStore({
	state: {
		trackListIds: [],
		myTrackListIds: [],
		trackBasicData: {}
	},

	mutations: {
		setTracksIds(state, data) {
			state.trackListIds = data;
		},
		setTrackBasicData(state, data) {
			state.trackBasicData = data;
		},
		setMyTracksIds(state, data) {
			state.myTrackListIds = data
		}
	},

	actions: {
		async searchTracks({ commit }, { axios, urlToFetch }) {
			try {
				const response = await axios.get(urlToFetch)
				urlToFetch === '/my_tracks' ? commit('setMyTracksIds', response.data) : commit('setTracksIds', response.data)
				console.log('Fetched tracks vuex:', response.data)
				return response.data
			} catch (error) {
				console.error('Error fetching tracks:', error)
				throw error
			}
		},
		storeTrackBasicData({ commit }, data) {
			commit('setTrackBasicData', data)
		}
	},

	getters: {
		trackListIds(state) {
			return state.trackListIds;
		},
		trackBasicData(state) {
			return state.trackBasicData
		},
		myTrackListIds(state) {
			return state.myTrackListIds
		}
	}
})
