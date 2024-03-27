import axios from 'axios';
import { useStore } from '../stores/TrackStore.js';

export async function fetchTracks(url) {
  const store = useStore();
  try {
    const fetchedTracks = await store.searchTracks({ urlToFetch: url });
    console.log('Fetched tracks requests:', fetchedTracks);
    return fetchedTracks; // Optionally, you can return the fetched data
  } catch (error) {
    console.error('Error fetching tracks:', error);
    throw error; // Rethrow the error to propagate it to the caller
  }
}

export async function fetchMyTracks() {
  const store = useStore();
  try {
    const fetchedMyTracks = await store.searchTracks({ urlToFetch: '/my_tracks' });
    console.log('Fetched my tracks:', fetchedMyTracks);
    return fetchedMyTracks; // Optionally, you can return the fetched data
  } catch (error) {
    console.error('Error fetching my tracks:', error);
    throw error; // Rethrow the error to propagate it to the caller
  }
}

export async function fetchConversation(conversationId) {
  try {
    const response = await axios.get(`/api/v1/track_conversations/${conversationId}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching conversation:', error);
    throw error; // Rethrow the error to propagate it to the caller
  }
}
