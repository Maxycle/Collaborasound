<template>
	<div class="border border-black rounded-xl">
		<table class="table-fixed">
			<thead class="border-b border-black">
				<tr class="">
					<th class="">{{ isInbox ? 'from' : 'To' }}</th>
					<th>Subject</th>
					<th class="pr-4">Received</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td v-for="str in stringz" :key="str" class="first:bg-red-300 last:bg-green-300">{{ str }}</td>
				</tr>
				<tr>
					<td>Witchy Woman</td>
					<td>The Eagles</td>
					<td>1972</td>
				</tr>
				<tr>
					<td>Shining Star</td>
					<td>Earth, Wind, and Fire</td>
					<td>1975</td>
				</tr>
			</tbody>
		</table>
	</div>


</template>

<script>

export default {
	components: {
	},

	props: {
		ids: {
			type: Object,
			default: {}
		},

		isInbox: {
			type: Boolean,
			default: true
		},

		isEditMode: {
			type: Boolean,
			default: false
		},

		bgColor: {
			type: String,
			default: ''
		}
	},

	data() {
		return {
			activeList: 'IN',
			stringz: ['The Sliding Mr. Bones', 'Malcolm Lockyer', '1961']
		}
	},

	methods: {
		activate(string) {
			this.activeList = string
		}
	}
}
</script>