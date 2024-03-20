import axios from 'axios';
import store from '../store/index.js';

export async function fetchTracks(url) {
  try {
    const fetchedTracks = await store.dispatch('searchTracks', {
      axios: axios.create(),
      urlToFetch: url,
    });
    console.log('Fetched tracks requests:', fetchedTracks);
  } catch (error) {
    console.error('Error fetching tracks:', error);
  }
}

export async function fetchMyTracks() {
  try {
    const fetchedMyTracks = await store.dispatch('searchTracks', {
      axios: axios.create(),
      urlToFetch: '/my_tracks',
    });
    console.log('Fetched my tracks:', fetchedMyTracks);
  } catch (error) {
    console.error('Error fetching my tracks:', error);
  }
}

export async function fetchConversation(conversationId) {
	try {
		const response = await axios.get(`/api/v1/conversations/${conversationId}`)
		return response.data
	} catch (error) {
		console.error('Error fetching conversation:', error)
	}
}