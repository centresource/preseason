@CS = {}

$ ->
  $(window).on 'resize', window.CS.setWelcomeHeight
  $('#go-to-about').click window.CS.scrollToEl
  window.CS.getReleaseInfo()
  window.CS.setWelcomeHeight()

CS.getReleaseInfo = ->
  $release = $('#release')
  latest = lscache.get 'latestRelease'
  tagIconHTML = '<spon class="fa fa-tag"></span> '

  return $release.html(tagIconHTML + latest) if latest

  $.get('https://api.github.com/repos/centresource/preseason/tags')
    .then (data) ->
      lscache.set 'latestRelease', data[0]['name'], 720
      $release.html tagIconHTML + data[0]['name']
    .then null, (err) ->
      $release.html 'available on <a href="https://www.github.com/centresource/preseason/tags">Github</a>'


CS.setWelcomeHeight = ->
  wH = window.innerHeight
  nH = document.getElementById('nav-external').clientHeight
  autoHeight = (wH - nH) + 'px'
  document.getElementById('welcome').style.height = autoHeight


CS.scrollToEl = (e) ->
  e.preventDefault()
  hash = $(e.currentTarget).attr('href')
  history.pushState(null, null, hash) if history.pushState

  $('html, body').animate
      scrollTop: $('#about').offset().top,
    1000
