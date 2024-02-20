<template>
  <div class="relative" @click="isOpen = !isOpen">
    <button class="bg-gray-300 py-2 px-4 flex justify-between items-center rounded w-full">
      <div class="text-nowrap">{{ heading }} </div>
      <Chevron class="ml-2 w-6" :class="{ 'rotate-180': isOpen }" />
    </button>
    <div v-show="isOpen" class="absolute z-10 mt-2 bg-white border rounded shadow-md w-full">
      <ul>
        <li v-for="option in options.names" :key="option" @click="selectOption(option, $event)" class="p-4 hover:bg-blue-500">
          {{ option }}
        </li>
      </ul>
    </div>
  </div>
</template>
  
<script>
import Chevron from '../svg/Chevron.vue'
import axios from 'axios'

export default {
  components: {
    Chevron
  },
  props: {
    heading: {
      type: String,
      default: 'ta mère en short',
    }
  },

  data() {
    return {
      isOpen: false,
      selectedOption: 'Select an option', // Default text
      // options: ['Option 1', 'Option 2', 'Option 3'], // Replace with your options
      options: {
        names: []
      },
      urlToFetch: ''
    };
  },
  created() {
    this.updateUrlToFetch(this.heading)
  },

  mounted() {
    // Initialize the derived variable when the component is mounted
    this.fetchOptions();
  },

  methods: {
    async fetchOptions() {
      try {
        // Make an HTTP request to fetch options based on the heading
        const response = await axios.get(`${this.urlToFetch}`)
        this.options = response.data; // Update options with the fetched data
        console.error('ze optios', this.options)
      } catch (error) {
        console.error('Error fetching options:', error)
      }
    },

    updateUrlToFetch(heading) {
      // Use a switch statement or any logic to set the derived variable
      switch (heading) {
        case 'Instrument recherchié':
          this.urlToFetch = '/instrus'
          break;
        case 'Genre de zikmu':
          this.urlToFetch = '/genrus'
          break;
        default:
          this.urlToFetch = '/tracks'
      }
    },

    selectOption(option, event) {
      this.selectedOption = option;
      this.isOpen = false;
      event.stopPropagation()
    }
  }
}
</script>

<style scoped>
/* In your CSS or styles */
.text-nowrap {
  white-space: nowrap;
}
</style>