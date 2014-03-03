################################################################################
# script: ChillSlide
# author: Mike McMillan <http://mcchill.in>
# license: MIT
################################################################################

class ChillSlide

	constructor: (options={}) ->

		ChillSlide.rowWidths = []
		ChillSlide.eachRow = []
		ChillSlide.addedWidths = []

		@container = options.container ? $(".chill-slide__container")
		@numOfRows = options.numOfRows ? 2

		@slidee = @container.find("ul")
		@items = @slidee.find("li")

		@createRowWidthsArray()
		@splitArray(ChillSlide.rowWidths)
		@calculateWidths(ChillSlide.eachRow)
		@largestWidth(ChillSlide.addedWidths)
		@setWidth()

	#############################	
	# createRowWidthsArray() returns an array
	# of all the container's li's widths
	# 
	# @return Array []
	#############################
	createRowWidthsArray: () =>
		rowWidth = 0
		@container.find("li").each ->
			rowWidth = $(this).outerWidth()
			ChillSlide.rowWidths.push(rowWidth)

	#############################	
	# splitArray() returns an array
	# with <@numOfRows> number of internal arrays,
	# 
	# @param Array []
	# @return Array []
	#############################
	splitArray: (rowWidths) =>
		numItemsInRow = Math.ceil(@items.length / @numOfRows)
		i = 0
		eachRow = []
		while i < rowWidths.length
			temparray = rowWidths.slice(i, i + numItemsInRow)
			ChillSlide.eachRow.push(temparray)
			i += numItemsInRow


	#############################	
	# calculateWidths() returns an array
	# of supplied array's sums
	# 
	# @param Array []
	# @return Array []
	#############################
	calculateWidths: (array) =>
		i = 0
		# Loop thru array of multiple arrays
		while i < array.length
			sum = 0
			# Get into a each array and add up the sum
			$.each array[i], ->
				sum += parseFloat(this) or 0

			ChillSlide.addedWidths.push(sum)
			i++


	#############################	
	# largestWidth() returns a number
	# of highest value in given array
	# 
	# @param Array []
	# @return Array []
	#############################
	largestWidth: (array) =>
		ChillSlide.largestWidth = Math.max.apply( Math, array )

	setWidth: () =>
		@slidee.css
			"width": ChillSlide.largestWidth


$ ->
	$(window).load ->
		window.chillSlide = new ChillSlide(
			container: $(".chill-slide__container"),
			numOfRows: 2
		)

