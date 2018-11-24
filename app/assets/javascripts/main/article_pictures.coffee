# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', ->

  $(document).bind "ajaxSuccess", "form.remote_form", (event, xhr, settings) ->
    console.log xhr.responseJSON
    console.log xhr.responseJSON.picture

  $(document).bind "ajaxError", "form.remote_form", (event, jqxhr, settings, exception) ->
    $.each jqxhr.responseJSON, (index, message) ->
      console.log message
