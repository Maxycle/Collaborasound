<template>
	<button class="relative bg-black text-white rounded-lg shadow-lg shadow-stone-400 p-4" @mouseover="showImage"
		@mouseout="hideImage">
		<img ref="imageRef" src="/home/maxycle/code/Collaborasound/app/assets/images/Flag_of_Anarcho-capitalism.svg.png"
			alt="yellow and black triangles"
			class="absolute inset-0 h-full w-full object-fill md:object-center rounded-lg hidden" />
		<slot></slot>
	</button>
</template>

<script>

export default {
	methods: {
		showImage() {
			this.$refs.imageRef.classList.remove("hidden");
		},
		hideImage() {
			this.$refs.imageRef.classList.add("hidden");
		}

	}
}
</script>

