ChillSlide
==========

Creates a multi-row sliding wrapper on an unordered list.

# Dependencies
[imagesLoaded](https://github.com/desandro/imagesloaded) - To make sure image widths are calculated correcly.

# Options:
    window.chillSlide = new ChillSlide(
        container: $(".chill-slide__container"), // jQuery selector.
        numOfRows: 3 // Desired number of rows in slider.
    )

# Markup
Accepts an unordered list wrapped in a container.

    <div class="chill-slide__container">
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
        window.chillSlide = new ChillSlide(
            container: $(".chill-slide__container"), 
            numOfRows: 3
        )