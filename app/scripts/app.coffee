@CS = {}

$ ->
  $(window).on 'resize', window.CS.setWelcomeHeight
  $('#go-to-about').click window.CS.scrollToEl

  $release = $('#release')
  request = $.get 'https://api.github.com/repos/centresource/preseason/tags'
  request.success (data) -> $release.html data[0]['name']
  request.error (jqXHR, textStatus, errorThrown) ->
    $release.html 'available on <a href="https://www.github.com/centresource/preseason/tags">Github</a>'


CS.setWelcomeHeight = ->
  wH = window.innerHeight
  nH = document.getElementById('nav-primary').clientHeight
  autoHeight = (wH - nH) + 'px'
  document.getElementById('welcome').style.height = autoHeight

window.CS.setWelcomeHeight()

CS.scrollToEl = (e) ->
  e.preventDefault()
  hash = $(e.currentTarget).attr('href')
  history.pushState(null, null, hash) if history.pushState

  $('html, body').animate
      scrollTop: $('#about').offset().top,
    2000

# Slide toggle tools list & rotate more icon
tech_container = $('.tech-container, .databases').hide()
$('#techLink').on 'click', (e) ->
  e.preventDefault()
  tech_container.slideToggle('slow')
  $(this).find('.fa').toggleClass('icon-rotate')

