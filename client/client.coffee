Template.ObserveAdd.events =
  'click a': (evt) ->
    node = evt.currentTarget
    mngId = $(node).attr 'mng-id'
    data = Events.find(
      id: mngId
    ).fetch()
    createJsonCode data

createJsonCode = (data) ->
  json = data && data.length > 0 && data[0]
  node = $ '#json-viewer'
  unless json
    return !!node.html 'Code is not rendered'
  jsonString = JSON.stringify json, null, 2
  $('#json-viewer').html("<pre>#{jsonString}</pre")
  $('#json-viewer pre').each (i, block) ->
    hljs.highlightBlock block

Template.EventsTypes.helpers do ->
  _events_type: ->
    EventsType.find({},
      # reactive: false
      sort:
        count: -1
    ).fetch()

$ ->
  Events.find().observe do ->
    added: (doc)->
      #render Template
      Blaze.renderWithData Template.ObserveAdd, doc, $('#events-container')[0], $('#events-container div:first-child')[0]
      removeOldNodes()

  removeOldNodes = ->
    #delete rows > 20 in container
    maxRows = 20
    while $('#events-container div').length >= maxRows
      $('#events-container div:last-child').remove()

Meteor.subscribe '_events_type'
