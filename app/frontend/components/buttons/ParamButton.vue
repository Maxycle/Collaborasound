<template>
  <button
    class="bg-red-500 flex border-2 border-green-500 text-xs m-1 hover:bg-blue-700 text-white py-2 pl-4 pr-2 rounded-l-full rounded-r-full">
    {{ heading }}
    <CloseRound class="ml-2 w-4" @click="kruigh"/>
  </button>
</template>

<script>
import CloseRound from '../svg/CloseRound.vue'

export default {
  components: {
    CloseRound
  },

  props: {
    heading: {
      type: String,
      default: 'ta mère en short',
    }
  },

  data() {
    return {

    }
  },

  methods: {
    kruigh() {
      this.$emit('removedd', this.heading)
    }
  }
}
</script>