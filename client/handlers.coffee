$ ->
  #show static panel
  $('#btn-stat, #btn-close-stat').on 'click', ->
    $('#main-container').toggleClass 'show-panel'

  #swith button type and text
  $('#btn-sabscription').on 'click', ->
    btn = $(this)
    stop = btn.hasClass 'btn-danger'
    btn.text if stop is true then 'Start' else 'Stop'
    btn.removeClass 'btn-danger btn-success'
    btn.addClass if stop is true then 'btn-success' else 'btn-danger'
    panelNode = $ '#events-panel'
    panelNode.toggleClass 'panel-danger'
