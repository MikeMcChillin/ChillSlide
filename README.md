ChillSlide
==========

Counts the items in your list and

*** Not quite ready for production.

# Dependencies
- jQuery
- [imagesLoaded](https://github.com/desandro/imagesloaded) - To make sure image widths are calculated correcly.

# Options:
Set the number of rows by a data-selector on your slider. If you don't set a data-selector, it will default to 1 row.

    // Coffeescript
    $(".chill-slide").chillSlide
        "numOfRows": 3 // The number of rows to create. Can alternatively be specified on the ChillSlide container as a `data-cs-rows` data attribute. If you specify both, this option will be preferred over the data-selector. Default: 1


    // Javascript
    $(".chill-slide").chillSlide({
        "numOfRows": 3
    });

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
            <!-- Or any number of images, really. That's the point. ;) -->
        </ul>
    </div>

# Initialize
Use jQuery, it's easy (and required for this plugin anyway).

    // Coffeescript
    $(window).load ->
        $(".chill-slide").chillSlide()

    // Javascript
    $(window).load(function() {
      $(".chill-slide").chillSlide();
    });


# Installing / Building
1. `npm install`
2. `bower Install`
3. `grunt serve`
4. To build: `grunt build`


# Roadmap
- Option: Use bin-packing library to get a tighter grid. Starting this on branch bin-pack.
