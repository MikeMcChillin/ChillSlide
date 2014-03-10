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
        @vw = $(window).width()

        # Set options defaults
        @numOfRows = options.numOfRows ? @container.attr("data-cs-rows") or 1

        # Create empty arrays
        ChillSlide.rowWidths = []
        ChillSlide.eachRow = []
        ChillSlide.addedWidths = []

        ChillSlide.position = 0
        ChillSlide.slideAmount = 0



        # Execute functions
        @createRowWidthsArray()
        @splitArray(ChillSlide.rowWidths)
        @calculateWidths(ChillSlide.eachRow)
        @largestWidth(ChillSlide.addedWidths)
        @setWidth()
        @loaded()
        @calculateAverageWidth(ChillSlide.rowWidths)
        @initInteractions()


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
            # console.log "ChillSlide.rowWidths: #{ChillSlide.rowWidths}"


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
            # console.log "ChillSlide.addedWidths: #{ChillSlide.addedWidths}"
            i++


    #############################
    # calculateAverageWidth() returns an integer
    # of supplied array's average Widths.
    #
    # @param Array []
    # @return Array []
    #############################
    calculateAverageWidth: (array) =>
        totalWidths = 0
        $.each array, ->
            totalWidths += this
        ChillSlide.averageWidth = totalWidths/array.length
        ChillSlide.slideAmount = (ChillSlide.averageWidth / ChillSlide.largestWidth) * 100
        console.log "Average: #{ChillSlide.averageWidth}"


    moveRight: (amount) =>
        ChillSlide.position = ChillSlide.position - amount
        max = -(@slidee.width() - @vw) / @slidee.width() * 100
        if (ChillSlide.position - amount) <= max
            ChillSlide.position = max
            @slidee.css
                "-webkit-transform": "translate3d(#{ChillSlide.position}%, 0, 0)"
        @slidee.css
            "-webkit-transform": "translate3d(#{ChillSlide.position}%, 0, 0)"


    moveLeft: (amount) =>
        ChillSlide.position = ChillSlide.position + amount
        max = 0
        console.log "max: #{max}"
        if (ChillSlide.position + amount) >= max
            console.log "fuck"
            ChillSlide.position = 0
            @slidee.css
                "-webkit-transform": "translate3d(#{ChillSlide.position}%, 0, 0)"
        @slidee.css
            "-webkit-transform": "translate3d(#{ChillSlide.position}%, 0, 0)"

    #############################
    # largestWidth() returns a number
    # of highest value in given array
    #
    # @param Array []
    # @return Array []
    #############################
    largestWidth: (array) =>
        ChillSlide.largestWidth = Math.max.apply( Math, array )


    #############################
    # setWidth() applies width in px to
    # @container's ul
    #
    # @return css width in px
    #############################
    setWidth: () =>
        @slidee.css
            "width": ChillSlide.largestWidth


    #############################
    # loaded() adds a class to the container
    # and sets a boolean to true
    #
    # @return addClass, boolean
    #############################
    loaded: () =>
        @container.addClass "loaded"
        ChillSlide.loaded = true

    initInteractions: () =>
        nextButton = @container.find("[data-cs-nav='next']")
        prevButton = @container.find("[data-cs-nav='prev']")

        nextButton.on "click", (e) =>
            @moveRight(ChillSlide.slideAmount)

        prevButton.on "click", (e) =>
            @moveLeft(ChillSlide.slideAmount)

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
      $(".chill-slide").chillSlide()
          # "numOfRows": 3

