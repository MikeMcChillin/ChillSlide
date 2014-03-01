# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class @NitroLinks

  @currentUrl =  ""
  @destinationUrl = ""
  @isHomePage = false

  @initHistoryChange: () ->
    History.Adapter.bind window,'popstate', () =>
      return false if NitroLinks.destinationUrl == NitroLinks.currentUrl
      State = History.getState()
      if window.nitroLinks?
        window.nitroLinks.parseUrl(State.hash)
      else
        window.nitroLinks = new NitroLinks('.work-container', '.home-container', {})
        window.nitroLinks.parseUrl(State.hash)  

  constructor: (@subContainer, @homeContainer, @options) ->
    @linkClicked = false
    @currentHomeY = 0
    @root_url = @options["root_url"] || ["/", ""]
    NitroLinks.destinationUrl = window.location.href.split("/").pop()
    NitroLinks.currentUrl = NitroLinks.destinationUrl
    @removeAnimationListeners()
    @makeHomePage()
    @initLinkBinding()

  parseUrl: (hash) =>
    NitroLinks.destinationUrl = hash
    if !$.inArray(hash, @rootUrl) > -1
      @toggleBodyHtml()
    else
      @loadHomePage()

  # in the event we go to a sub-page directly, not from the homepage
  makeHomePage: () =>
    if $(@homeContainer).children().length < 1
      @fetchHomePageData()

  fetchHomePageData: () =>
    $.ajax
      url: "/default?js=true"
      type: 'GET'
      dataType: 'html'
      success: (data) =>
        @appendHomePage(data)

  appendHomePage: (data) =>
    # hide homepage before appending html
    @hideHomePage()
    # append html in background
    $(@homeContainer).append(data)

  initLinkBinding: () =>
    $('body').delegate 'a', 'click', @yieldBodyContent

  yieldBodyContent: (e) =>
    e.preventDefault()
    @linkClicked = true
    target = $(e.target).closest('a')
    parent = $(e.target).closest('img')
    url = $(target).attr('href')
    @pinImageOnClick(parent, target, url)

  pinImageOnClick: (parent, target, url) =>
    if parent.length
      #if there is an imagem delay the hiding of that image
      coords = $(parent).offset()
      newParent = $(parent).clone()
      $(newParent).css('position', 'fixed')
      $(newParent).css('left', coords.left)
      $(newParent).css('top', (coords.top) - $(window).scrollTop())
      $('body').prepend(newParent)
      url = $(target).attr('href')
      NitroLinks.destinationUrl = url
      @toggleBodyHtml()
      $(newParent).animate({
        'top': 100,
        'left':100
        }, 700, () =>
      )
      $(newParent).animate({
        'opacity': 0
        }, 1000, () =>
        $(newParent).remove()
      )
    else
      NitroLinks.destinationUrl = url
      @toggleBodyHtml()

  toggleBodyHtml: () =>
    if $.inArray(NitroLinks.destinationUrl, @root_url) > -1
      @loadHomePage()
    else
      @loadSubPage()

  loadSubPage: () =>
    @currentHomeY = $(window).scrollTop()
    @addAnimationListeners()
    $(@animationContainer()).addClass('animated fadeOut')

  loadHomePage: () =>
    @removeAnimationListeners()
    @clearChildHtml()
    @updateUrl()
    @scrollToOldPosition()

  addAnimationListeners: () =>
    $(@animationContainer()).on 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', @animationCallback

  removeAnimationListeners: () =>
    $(@animationContainer()).unbind 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'

  animationCallback: () =>
    @removeAnimationListeners()
    @scrollToTop()
    @hideHomePage()
    @getBodyHtml(NitroLinks.destinationUrl)

  hideHomePage: () =>
    $(@homeContainer).css('position', 'absolute')
    $(@homeContainer).removeClass('fadeIn')
    $(@homeContainer).css('z-index', '-1')
    $(@homeContainer).css('opacity', 0)
    $(@homeContainer).addClass('animated fadeOut')

  scrollToOldPosition: () =>
    $(window).scrollTop(@currentHomeY)

  scrollToTop: () =>
    $(window).scrollTop(0)

  getBodyHtml: (url) =>
    $.ajax
      url: "#{url}?js=true"
      type: 'GET'
      dataType: 'html'
      success: (data) =>
        @linkClicked = false
        @htmlCallback(data)

  clearChildHtml: () =>
    $(@subContainer).empty()
    $(@homeContainer).css('position', 'relative')
    $(@homeContainer).css('z-index', '1')
    $(@homeContainer).removeClass('fadeOut').addClass('fadeIn')

  updateUrl: () =>
    NitroLinks.currentUrl = NitroLinks.destinationUrl
    NitroLinks.destinationUrl = null
    history.pushState({}, "", NitroLinks.currentUrl)

  htmlCallback: (data) =>
    $(@subContainer).removeClass "fadeOut"
    $(@subContainer).addClass "animated fadeIn"
    $(@subContainer).html(data)
    setTimeout( =>
      $(@subContainer).removeClass "fadeIn"
    , 2000)
    @updateUrl()

  isSubPage: () =>
    NitroLinks.currentUrl != "" && NitroLinks.currentUrl != "/"

  animationContainer: () =>
    if @isSubPage() then @subContainer else @homeContainer

$ -> 
  $(window).load ->
    window.nitroLinks = new NitroLinks('.work-container', '.home-container', {})
    NitroLinks.initHistoryChange()