module.exports = {
	content: [
		'./app/views/**/*.{html,html.erb,erb}',
		'./app/views/devise/**/*.{html,html.erb,erb}',
		'./app/frontend/components/**/*.{vue,js,ts,jsx,tsx}',
		'./app/frontend/**/*.{vue,js,ts,jsx,tsx}',
		'./app/**/*.{vue,js,ts,jsx,tsx}',
	],
	theme: {
		extend: {
			fontFamily: {
				'sans': ['Kode Mono', 'sans-serif'],
				'sus': ['Barriecito', 'sans-serif']
			},
			backgroundImage:{
        'anarcap': 'url(/home/maxycle/code/Collaborasound/app/assets/images/Flag_of_Anarcho-capitalism.png)',
				'croco': 'url(/home/maxycle/code/Collaborasound/app/assets/images/croco.jpg)'
      },
			colors: {
        'anarcapYellow': '#fdfd00',
      },
		},
	},
	plugins: [],
}