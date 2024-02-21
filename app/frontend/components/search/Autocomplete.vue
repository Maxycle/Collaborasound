<template>
	<div>
		<!-- <label for="autocomplete" class="text-white">{{ header }}</label> -->
		<div class="relative">
			<input type="text" id="autocomplete" :placeholder="placeholder" v-model="selectedItem" @input="onInput"
				class="bg-gray-300 py-2 px-4 flex justify-between items-center rounded w-full" />
			<ul v-if="filteredItems.length" class="absolute z-10 mt-2 bg-white border rounded shadow-md w-full">
				<li v-for="item in filteredItems" :key="item" @click="selectItem(item)" class="p-4 rounded hover:bg-blue-500">
					{{ item }}
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
import axios from 'axios'

export default {
	props: {
		heading: {
			type: String,
			default: 'ta mère en short',
		}
	},

	data() {
		return {
			selectedItem: '',
			filteredItems: [],
			options: [],
			urlToFetch: '',
			placeholder: 'ta gueule',
			selectedItemId: undefined
		};
	},

	created() {
		this.updateUrlToFetch(this.heading)
	},

	mounted() {
		this.fetchOptions();
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
			this.selectedItem = item
			this.filteredItems = []
			this.selectedItemId = JSON.parse(JSON.stringify(this.options)).find(obj => obj.name === item).id
			this.$emit('item-selected', { queryParam: this.heading, queryParamValue: this.selectedItem, queryParamId: this.selectedItemId })
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
					this.placeholder = 'Islamaverybad'
					break;
				case 'trackTitle':
					this.urlToFetch = '/locs'
					this.placeholder = 'Allah akbar'
					break;
				default:
					this.urlToFetch = '/tracks'
			}
		},
	},
};
</script>

  