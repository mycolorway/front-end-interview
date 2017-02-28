$('button').on 'click', (e) ->
  $box = $('.box')
  $box.css 'display', 'block'

  if $box.hasClass('showing') or $box.hasClass('hiding')
    $box.toggleClass('showing hiding')
  else
    $box.addClass 'hiding'

$('.box').on 'animationend', (e) ->
  $(this).css 'display', 'none' if $(this).hasClass 'hiding'
