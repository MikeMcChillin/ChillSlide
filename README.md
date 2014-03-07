ChillSlide
==========

Creates a multi-row sliding wrapper on an unordered list.

# Dependencies
[imagesLoaded](https://github.com/desandro/imagesloaded) - To make sure image widths are calculated correcly.

# Options:
Set the number of rows by a data-selector on your slider. If you don't set a data-selector, it will default to 1 row.

    $(".chill-slide").chillSlide
        "numOfRows": 3 // The number of rows to create. Can alternatively be specified on the ChillSlide container as a `data-cs-rows` data attribute.
        "scrollThrottle": 3 // The number of px to throttle the scroll tolerance. Lower is usually better. Default: 3


# Markup
Accepts an unordered list wrapped in a container.

    <div class="chill-slide" data-num-rows="3">
        <ul>
            <li><img src="images/350x100.gif" alt="" /></li>
            <li><img src="images/50x100.gif" alt="" /></li>
            <li><img src="images/400x100.gif" alt="" /></li>
            <li><img src="images/75x100.gif" alt="" /></li>
            <li><img src="images/100x100.gif" alt="" /></li>
            <li><img src="images/200x100.gif" alt="" /></li>
            <li><img src="images/250x100.gif" alt="" /></li>
            <li><img src="images/320x100.gif" alt="" /></li>
            <li><img src="images/190x100.gif" alt="" /></li>
            <li><img src="images/250x100.gif" alt="" /></li>
            <li><img src="images/50x100.gif" alt="" /></li>
            <li><img src="images/400x100.gif" alt="" /></li>
            <li><img src="images/75x100.gif" alt="" /></li>
            <li><img src="images/100x100.gif" alt="" /></li>
            <li><img src="images/200x100.gif" alt="" /></li>
            <li><img src="images/250x100.gif" alt="" /></li>
            <li><img src="images/320x100.gif" alt="" /></li>
            <li><img src="images/190x100.gif" alt="" /></li>
            <li><img src="images/370x100.gif" alt="" /></li>
            <li><img src="images/120x100.gif" alt="" /></li>
            <li><img src="images/120x100.gif" alt="" /></li>
            <li><img src="images/340x100.gif" alt="" /></li>
            <li><img src="images/390x100.gif" alt="" /></li>
            <li><img src="images/210x100.gif" alt="" /></li>
            <li><img src="images/150x100.gif" alt="" /></li>
            <li><img src="images/280x100.gif" alt="" /></li>
            <li><img src="images/240x100.gif" alt="" /></li>
            <li><img src="images/280x100.gif" alt="" /></li>
            <li><img src="images/380x100.gif" alt="" /></li>
            <li><img src="images/130x100.gif" alt="" /></li>
        </ul>
    </div>

# Initialize
Pass the jQuery selector of the unordered lists' container and specify the number of rows you'd like.

    $(window).load ->
        $(".slider").chillSlide()

# Building
`grunt serve`, `grunt build`

# Roadmap
Throttle scroll
Resize Event
Option: Order doesn't matter, just make the rows as even-width as possible.
