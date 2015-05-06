$(document).ready ->
   # Hide additional site content. This can be toggled by calling the
   # `showMore` function (see below).
   $('#learn-more').hide()

   # Initialize parallax components.
   $('.parallax').parallax()


# Automatically the page to a specified div.
scrollToDiv = (elem, delay) ->

   # Adjust the page so `elem` is at the top.
   _move_to_top = (elem) ->
      $('html,body').animate(
         scrollTop: $(elem).offset().top
      , 1000)

   if delay
      setTimeout(-> _move_to_top elem, delay)
   else
      _move_to_top elem

showMore = ->
   # Un-hide additional site content and automatically scroll to the 
   # first section after a brief delay.
   $('#learn-more').fadeIn ->
      scrollToDiv "#learn-more", 300

showModal = ->
   $('#sign-up-modal').openModal()

register = (elem) ->

   firstname = $(elem).find('.first-name').val()
   lastname  = $(elem).find('.last-name').val()
   email     = $(elem).find('.email').val()

   $(elem).find('.first-name').val('')
   $(elem).find('.last-name').val('')
   $(elem).find('.email').val('')

   document.location.href= 'thank-you.html'
