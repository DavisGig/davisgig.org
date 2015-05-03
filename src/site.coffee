$(document).ready ->
   $('#learn-more').hide()
   $('.parallax').parallax()

scrollToDiv = (elem, delay) ->
   _move_to_top = (elem) ->
      $('html,body').animate(
         scrollTop: $(elem).offset().top
      , 1000)

   if delay
      setTimeout(->
         _move_to_top elem
      , delay)
   else
      _move_to_top elem

showMore = ->
   $('#learn-more').fadeIn ->
      scrollToDiv "#learn-more", 500

showModal = ->
   $('#sign-up-modal').openModal()
