# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#article_tags').tagit
    fieldName:   'article[tag_list]'
    singleField: true
    availableTags: gon.available_tags_and_count
    autocomplete: {
        autoFocus: true,
        focus: (event, ui) ->
          event.preventDefault()
        delay: 0,
        minLength: 2
      },
      preprocessTag: (val) ->
        val.replace(/\(\d+\)/g, "")
