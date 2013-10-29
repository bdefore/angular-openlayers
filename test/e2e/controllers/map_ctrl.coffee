describe 'Sanity', ->

	beforeEach ->
		browser().navigateTo('/')

	it 'can enter valid data into zoom input', ->
		input('zoom').enter('6')

	it 'can enter valid data into latitutde input', ->
		input('lat').enter('-6.0')

	it 'can enter valid data into longitude input', ->
		input('lon').enter('6.0')