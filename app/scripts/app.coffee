@CS = {}

$ ->
  $(window).on 'resize', window.CS.setWelcomeHeight
  $('#go-to-about').click window.CS.scrollToEl
  window.CS.getReleaseInfo()
  window.CS.setWelcomeHeight()

CS.getReleaseInfo = ->
  $release = $('#release')
  latest = lscache.get 'latestRelease'

  return $release.html latest if latest

  request = $.get 'https://api.github.com/repos/centresource/preseason/tags'
  request.success (data) ->
    if data.length is 0
      str = 'in pre-release development'
      lscache.set 'latestRelease', str, 1440
      $release.html str
    else
      lscache.set 'latestRelease', data[0]['name'], 720
      $release.html data[0]['name']
  request.error ->
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
