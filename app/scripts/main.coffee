################################################################################
# script: ChillSlide
# author: Mike McMillan <http://mcchill.in>
# license: MIT
################################################################################

class ChillSlide

	constructor: (container, options={}) ->

		# Cache selectors
		@container = container
		@slidee = @container.find("ul")
		@items = @slidee.find("li")

		# Set options defaults
		@numOfRows = options.numOfRows ? @container.attr("data-cs-rows") or 1

		# Create empty arrays
		ChillSlide.rowWidths = []
		ChillSlide.eachRow = []
		ChillSlide.addedWidths = []

		# Execute functions
		@createRowWidthsArray()
		@splitArray(ChillSlide.rowWidths)
		@calculateWidths(ChillSlide.eachRow)
		@largestWidth(ChillSlide.addedWidths)
		@setWidth()
		@loaded()

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

	loaded: () =>
		@container.addClass "loaded"
		ChillSlide.loaded = true


#############################
# Turn it into a jQuery plugin
#############################
$ = jQuery
$.fn.extend
	chillSlide: (options) ->
		this.each ->
			$this = $(this)
			new ChillSlide($this, options)
$ ->
	$(window).load ->
		$(".slider").chillSlide()

