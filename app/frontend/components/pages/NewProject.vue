<template>
	<Container>
		<div class="w-4/5">
			<div class="flex justify-center space-x-4 pb-4">
				<div class="mx-auto max-w-2xl lg:mx-0 lg:max-w-none">
					<div class="grid grid-cols-4 gap-2 sm:mt-20">
						<div v-for="label in newProjectParams" class="">{{ label.name }}</div>
						<div>Track title</div>
						<div v-for="param in newProjectParams" :key="param.name" class="">
							<Autocomplete :heading="param.name" @item-selected="addParameters" @item-inputted="onNewItemInput" />
						</div>
						<input type="text" id="autocomplete" placeholder="Allah Akbar" v-model="trackTitle"
							class="bg-gray-300 py-2 px-4 flex justify-between items-center rounded w-full" />
						<div class="flex flex-wrap mt-2">
							<div v-for="item in genresList" :key="item">
								<ParamButton :heading="item" @removedd="removeParameters('Genre de zikmu', item)" />
							</div>
						</div>
						<div class="flex flex-wrap mt-2">
							<div v-for="item in instrumentsList" :key="item">
								<ParamButton :heading="item" @removedd="removeParameters('Instrument recherchié', item)" />
							</div>
						</div>
						<div class="flex flex-wrap mt-2">
							<div v-for="item in locationsList" :key="item">
								<ParamButton :heading="item" @removedd="removeParameters('Où ca ??', item)" />
							</div>
						</div>
						<button
							class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-start-2 col-span-2 mt-2">Upload
							your track</button>
						<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded col-start-2 col-span-2"
							@click="createTrack">Create
							project</button>
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

export default {
	components: {
		Container,
		Autocomplete,
		ParamButton
	},

	data() {
		return {
			trackTitle: '',
			newInstrument: '',
			newGenre: '',
			newLocation: '',
			instrumentParamId: undefined,
			genreParamId: undefined,
			locationParamId: undefined,
			urlToFetch: '',
			instrumentsList: [],
			genresList: [],
			locationsList: [],
			newProjectParams: [
				{ name: 'Genre de zikmu', value: '12' },
				{ name: 'Instrument recherchié', value: '300+' },
				{ name: 'Où ca ??', value: '40' }
				// { name: 'trackTitle', value: 'kruUugh'}
			]
		}
	},

	methods: {
		async createTrack() {
			if (this.instrumentParamId === undefined) {
				await this.createResource('instruments', this.newInstrument, 'newInstrument', 'instrumentParamId');
			}

			if (this.genreParamId === undefined) {
				await this.createResource('genres', this.newGenre, 'newGenre', 'genreParamId');
			}

			if (this.locationParamId === undefined) {
				await this.createResource('locations', this.newLocation, 'newLocation', 'locationParamId');
			}

			try {
				const response = await axios.post('/tracks', {
					music_track: {
						title: this.trackTitle,
						instrument_wanted_id: this.instrumentParamId,
						music_genre_id: this.genreParamId,
						location_id: this.locationParamId,
						user_id: 3
					}
				})
				console.log('New track created:', response.data);
			} catch (error) {
				console.error('Error creating track:', error);
			}
		},

		async createResource(endpoint, value, dataProp, idProp) {
			try {
				const response = await axios.post(`/${endpoint}`, { [endpoint.slice(0, -1)]: { name: value } });
				this[dataProp] = '';
				this[idProp] = response.data.id;
				console.log(`New ${endpoint} created:`, response.data);
			} catch (error) {
				console.error(`Error creating ${endpoint}:`, error);
			}
		},

		addParameters(obj) {
			if (obj.queryParamValue !== '') {
				switch (obj.queryParam) {
					case 'Instrument recherchié':
						this.instrumentsList.push(obj.queryParamValue)
						this.instrumentParamId = obj.queryParamId
						break;
					case 'Genre de zikmu':
						this.genresList.push(obj.queryParamValue)
						this.genreParamId = obj.queryParamId
						break;
					case 'Où ca ??':
						this.locationsList.push(obj.queryParamValue)
						this.locationParamId = obj.queryParamId
						break;
					default:
						this.urlToFetch = '/tracks';
				}
			}
		},

		onNewItemInput(obj) {
			switch (obj.queryParam) {
				case 'Instrument recherchié':
					this.newInstrument = obj.queryParamValue
					break;
				case 'Genre de zikmu':
					this.newGenre = obj.queryParamValue
					break;
				case 'Où ca ??':
					this.newLocation = obj.queryParamValue
					break;
				default:
					this.urlToFetch = 'kruigh';
			}
		},

		removeParameters(additionalParameter, itemToRemove) {
			switch (additionalParameter) {
				case 'Instrument recherchié':
					this.instrumentsList = this.instrumentsList.filter(item => item !== itemToRemove);
					break;
				case 'Genre de zikmu':
					this.genresList = this.genresList.filter(item => item !== itemToRemove);
					break;
				case 'Où ca ??':
					this.locationsList = this.locationsList.filter(item => item !== itemToRemove);
					break;
				default:
					this.urlToFetch = '/tracks';
			}
		}

	}
}
</script>