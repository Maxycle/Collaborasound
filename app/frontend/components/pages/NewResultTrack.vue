<template>
	<Container>
		<div class="w-4/5">
			<div class="flex justify-center space-x-4 pb-4">
				<div class="mx-auto max-w-2xl lg:mx-0 lg:max-w-none">
					<div class="grid grid-cols-2 gap-2 mb-2">
						<div>Instrument(s) added</div>
						<div></div>
						<Autocomplete heading='Instrument recherchié' @item-selected="addParameters"
							@item-inputted="onNewItemInput" />
						<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold rounded">Upload
							your track</button>
						<div class="flex flex-wrap mt-2">
							<div v-for="item in instrumentsList" :key="item">
								<ParamButton :heading="item" removable @removedd="removeParameters" />
							</div>
						</div>
						<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-span-2"
							@click="createTrack">Add your création</button>
					</div>
				</div>
			</div>
		</div>
	</Container>
</template>

<script>
import axios from 'axios'
import Container from '../containers/Container.vue'
import Autocomplete from '../search/Autocomplete.vue'
import ParamButton from '../buttons/ParamButton.vue'
import router from '../../entrypoints/router.js'
import { fetchTracks, fetchMyTracks } from '../../helpers/requests.js'
import { mapGetters } from 'vuex'

export default {
	components: {
		Container,
		Autocomplete,
		ParamButton
	},

	data() {
		return {
			trackId: Number(this.$route.params.zeTrackId),
			instrumentParamId: undefined,
			instrumentParamIds: [],
			instrumentsList: [],
			newInstrument: ''
		}
	},

	computed: {
		...mapGetters(['trackBasicData']),
		genres() {
			return this.trackBasicData.music_genres
		},
		author() {
			return this.trackBasicData.author;
		},
		instruments() {
			return this.trackBasicData.instruments
		},
		band() {
			return this.trackBasicData.band;
		},
		title() {
			return this.trackBasicData.title;
		}
	},

	methods: {
		async createTrack() {
			if (this.instrumentParamId === undefined && this.newInstrument !== '') {
				await this.createResource('instruments', this.newInstrument, 'newInstrument', 'instrumentParamIds');
			}

			try {
				const response = await axios.post('/tracks', {
					music_track: {
						title: this.title,
						instrument_ids: this.instrumentParamIds,
						music_genre_ids: this.genres.map(item => item.id),
						parent_id: this.trackId
					}
				})

				await Promise.all([
					fetchTracks('/tracks'),
					fetchMyTracks()
				])

				router.push('/')
				console.log('New track created:', response.data);
			} catch (error) {
				console.error('Error creating track:', error);
			}
		},

		async createResource(endpoint, value, dataProp, idsProp) {
			try {
				const response = await axios.post(`/${endpoint}`, { [endpoint.slice(0, -1)]: { name: value } });
				this[dataProp] = '';
				this[idsProp].push(response.data.id)
				console.log(`New ${endpoint} created:`, response.data);
			} catch (error) {
				console.error(`Error creating ${endpoint}:`, error);
			}
		},

		addParameters(obj) {
			if (obj.queryParamValue !== '' && !this.instrumentsList.includes(obj.queryParamValue)) {
				this.instrumentsList.push(obj.queryParamValue)
				this.instrumentParamId = obj.queryParamId
				this.instrumentParamIds.push(this.instrumentParamId)
			}
		},

		onNewItemInput(obj) {
			this.instrumentParamId = undefined
			this.newInstrument = obj.queryParamValue
		}
	},

	removeParameters(itemToRemove) {
		this.instrumentsList = this.instrumentsList.filter(item => item !== itemToRemove);
	}
}
</script>