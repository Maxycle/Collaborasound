<template>
	<div>
		<div class="relative">
			<input v-if="heading !== 'Où ca ??'" type="text" id="autocomplete" :placeholder="placeholder" v-model="selectedItem"
				@input="onInput" class="bg-gray-300 py-2 px-4 flex justify-between items-center rounded w-full" />
			<input v-else type="text" id="autocomplete" ref="geocoder" :placeholder="placeholder" v-model="geoQuery"
				@input="handleInputGeocoder" class="bg-gray-300 py-2 px-4 flex justify-between items-center rounded w-full" />
			<ul v-if="dropdownOptions.length" class="absolute z-10 mt-2 bg-white border rounded shadow-md w-full">
				<li v-for="item in dropdownOptions" :key="item" @click="selectItem(item)" class="p-4 rounded hover:bg-blue-500">
					<div v-if="this.heading === 'Où ca ??'">{{ item.place_name }}</div>
					<div v-else> {{ item }}</div>
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
import axios from 'axios'
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder'

export default {
	props: {
		heading: {
			type: String,
			default: 'ta mère en short',
		},
		isLocationInput: {
			type: Boolean,
			default: false
		}
	},

	data() {
		return {
			selectedItem: '',
			geoQuery: '',
			filteredItems: [],
			options: [],
			urlToFetch: '',
			placeholder: 'ta gueule',
			geocoderResult: [],
			selectedItemId: undefined,
			itemSelected: false,
			coordinates: []
		};
	},

	created() {
		this.updateUrlToFetch(this.heading)
	},

	mounted() {
		this.fetchOptions();
		if (this.heading === 'Où ca ??') {
			this.initializeGeocoder()
		}
	},

	computed: {
		dropdownOptions() {
			console.log('the dropdownn', this.geocoderResult, this.filteredItems)
			if (this.heading === 'Où ca ??') return this.geocoderResult
			else return this.filteredItems
		}

	},

	methods: {
		async fetchOptions() {
			try {
				const response = await axios.get(`${this.urlToFetch}`)
				this.options = response.data;
			} catch (error) {
				console.error('Error fetching options:', error)
			}
		},

		filterItems() {
			const query = this.selectedItem.toLowerCase();
			this.filteredItems = query === '' ? [] : this.options.filter(item => item.name.toLowerCase().includes(query)).map(item => item.name)
		},

		selectItem(item) {
			if (this.heading === 'Où ca ??') {
				this.geoQuery = item.place_name
				this.coordinates = item.geometry.coordinates
				this.geocoderResult = []
				this.$emit('item-selected', { queryParam: this.heading, coordinates: this.coordinates })
			} else {
				this.selectedItem = item
				this.selectedItemId = JSON.parse(JSON.stringify(this.options)).find(obj => obj.name === item).id
				this.$emit('item-selected', { queryParam: this.heading, queryParamValue: this.selectedItem, queryParamId: this.selectedItemId })
			}
			this.filteredItems = []
			this.itemSelected = true
		},

		onInput() {
			if (this.selectedItem === '') {
				this.selectedItemId = undefined;
				this.filteredItems = []
				this.$emit('item-selected', { queryParam: this.heading, queryParamValue: '', queryParamId: undefined });
			} else {
				this.$emit('item-inputted', { queryParam: this.heading, queryParamValue: this.selectedItem });
				this.filterItems();
			}
		},

		updateUrlToFetch(heading) {
			switch (heading) {
				case 'Instrument recherchié':
					this.urlToFetch = '/instruments'
					this.placeholder = 'Chainsaw'
					break;
				case 'Genre de zikmu':
					this.urlToFetch = '/genres'
					this.placeholder = 'Fuck metal'
					break;
				case 'Où ca ??':
					this.urlToFetch = '/locations'
					this.placeholder = 'Islamaveryverybad'
					break;
				case 'trackTitle':
					this.urlToFetch = '/locs'
					this.placeholder = 'Allah akbar'
					break;
				default:
					this.urlToFetch = '/tracks'
			}
		},

		initializeGeocoder() {
			mapboxgl.accessToken = 'pk.eyJ1Ijoia2ViYWJhY29vbCIsImEiOiJjbHQ1bnVoN3QwMmdnMmxzMGppenlja3VvIn0.IFeRK3uh56z33cdb--8Nbw';
			this.geocoder = new MapboxGeocoder({
				accessToken: mapboxgl.accessToken,
				types: 'country,region,place,postcode,locality,neighborhood'
			});

			this.geocoder.addTo(this.$refs.geocoder);
			const results = document.getElementById('result');

			this.geocoder.on('result', (e) => {
				this.geocoderResult = JSON.stringify(e.result, null, 2);
			})

			this.geocoder.on('clear', () => {
				this.geocoderResult = []
			})
		},

		handleInputGeocoder() {
			if (this.geoQuery.length >= 4) {
				this.triggerGeocodeRequest();
			}
		},

		async triggerGeocodeRequest() {
			try {
				const response = await axios.get(`https://api.mapbox.com/geocoding/v5/mapbox.places/${this.geoQuery}.json?proximity=ip&access_token=pk.eyJ1Ijoia2ViYWJhY29vbCIsImEiOiJja211d2g3NXoxMjl2MnZteGxsNWt4YzBxIn0.UB5MlsB8rIYsBg3nSJBs_A`)
				this.geocoderResult = response.data.features
				console.log('in ze geocoder', this.geocoderResult)
			} catch (error) {
				console.error('Error fetching tracks:', error)
			}
		}
	}
}
</script>

  