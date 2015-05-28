$(document).ready ->
   # Hide additional site content. This can be toggled by calling the
   # `showMore` function (see below).
   $('#learn-more').hide()

   # Initialize parallax components.
   $('.parallax').parallax()

   $.getJSON '//www.davisgig.org/api/stats', (data) ->
      $('#total-sign-ups').text data.contacts

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

   # Get the form data from the specified element.
   firstName = $(elem).find('.first-name')
   lastName = $(elem).find('.last-name')
   email = $(elem).find('.email')

   # Validate form data before registering.
   for e in [firstName, lastName, email]
      if !e.hasClass("valid")
         e.focus()
         return false

   # Call the sign-up endpoint to register the user.
   $.ajax
      type: 'POST'
      url:  '//www.davisgig.org/api/sign-up'
      data: JSON.stringify
         firstName: firstName.val()
         lastName:  lastName.val()
         email:     email.val()
      dataType: 'json'
      contentType: 'application/json; charset=utf-8'
      success: (data) ->
         document.location.href= 'thank-you.html'
