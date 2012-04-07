#= require ../vendor/bootstrap
#= require ../vendor/jquery


$ ->

  $('.scroller').each ->
    href = $(this).attr 'href'
    
    $(this).click (e) ->
      e.preventDefault()
      $.scrollTo(href, 500)

  class RetinaImage
    constructor: (@img) ->
      @width = @img.clip?.width or @img.style.pixelWidth or @img.offsetWidth
      @height = @img.clip?.height or @img.style.pixelHeight or @img.offsetHeight
      path_segments = @img.getAttribute("src").split('.')
      path_without_extension = path_segments.slice(0, (path_segments.length - 1)).join(".")
      extension = "." + path_segments[path_segments.length - 1]
      @at_2x_path = path_without_extension + "@2x" + extension
      @apply_2x() if @has_2x()


    has_2x: ->
      http = new XMLHttpRequest()
      http.open('HEAD', @at_2x_path, false)
      try
        http.send()
      http.status is 200


    apply_2x: ->  
      @img.setAttribute('width', @width)
      @img.setAttribute('height', @height)
      @img.setAttribute("src", @at_2x_path)


  if window.devicePixelRatio > 1 then window.onload = ->
    for img in document.getElementsByTagName("img")
      do load = ->
        if img.complete  
          new RetinaImage(img)           
        else
          setTimeout load, 5