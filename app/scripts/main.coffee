################################################################################
# script: ChillSlide
# author: Mike McMillan <http://mcchill.in>
# license: MIT
################################################################################

class ChillSlide

	constructor: (options={}) ->
		# Set some default options
		ChillSlide.width = 0
		@container = options.container ? $(".chill-slide__container")
		@numOfRows = options.numOfRows ? 2
		@slidee = @container.find("ul")
		@items = @slidee.find("li")
		@createRows()
		@wrapUl()
		@calculateWidths()

	createRows: () =>
		numItemsInRow = Math.ceil(@items.length / @numOfRows)
		$lis = @slidee.children().filter(":gt(" + (numItemsInRow - 1) + ")")
		loop_ = Math.ceil($lis.length / numItemsInRow)
		i = 0

		while i < loop_
		  @slidee = $("<ul />").append($lis.slice(i * numItemsInRow, (i * numItemsInRow) + numItemsInRow)).insertAfter(@slidee)
		  i++

	wrapUl: () =>
		@container.children().wrapAll("<div class='chill-slide__slidee'></div>")

	calculateWidths: () =>
		@container.imagesLoaded =>
			rowWidths = []
			@container.find("ul").each (i, obj) ->

				rowWidth = 0
				$(this).find("li").each (i, obj) ->
					rowWidth = rowWidth + $(this).outerWidth()
					$(this).addClass "item"

				$(this).addClass "row#{i + 1}"
				rowWidths.push(rowWidth)
				ChillSlide.width = Math.max.apply Math, rowWidths

			@setWidth(ChillSlide.width)

	setWidth: (width) =>
		@container.find(".chill-slide__slidee").css
			"width": width


$ ->
	$(window).load ->
		window.chillSlide = new ChillSlide(
			container: $(".chill-slide__container"),
			numOfRows: 2
		)

