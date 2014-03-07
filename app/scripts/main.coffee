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

		ChillSlide.end = 0
		ChillSlide.vw = $(window).width()

		# Set options defaults
		@numOfRows = options.numOfRows ? @container.attr("data-cs-rows") or 1
		@scrollThrottle = options.scrollThrottle ? 3

		console.log "scrollThrottle: #{@scrollThrottle}"

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
		@wheelThrottle(@scrollThrottle)


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


	wheelThrottle: (throttle) =>

		@container.on "mousewheel", (event) ->
			lastAnimation = 0
			animationTime = 1000
			quietPeriod = 500

			timeNow = new Date().getTime()
			distanceX = event.deltaX * event.deltaFactor
			distanceY = event.deltaY * event.deltaFactor

			# Simple throttle first to make sure
			# we're not firing events like crazy
			if (timeNow - lastAnimation < quietPeriod + animationTime)
		        event.preventDefault()
		        console.log "throttl'd"

			if ((distanceY < -throttle) or (distanceY > throttle)) and ((distanceX > -throttle) or (distanceX < throttle))
				lastAnimation = timeNow
				$(this).css
					"overflow-x": "hidden"
			else
				lastAnimation = timeNow
				$(this).css
					"overflow-x": "scroll"




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
	# $(window).load ->
	$(".chill-slide").chillSlide
		# "numOfRows": 3
		"scrollThrottle": 3

