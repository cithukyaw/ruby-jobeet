# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#search-keywords').on 'keyup', (e) ->
    val = $(this).val()
    if val.length > 2
      $('#search-button').prop 'disabled', false
    else
      $('#search-button').prop 'disabled', true

  $('#search-keywords').keyup();
