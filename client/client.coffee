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

Template.ObserveAdd.helpers do ->
  createdAt: (date) ->
    dt = new Date date
    return '' if isNaN dt
    pad = (s) ->
      ('0' + s.toString()).substr -2,2
    y = dt.getFullYear()
    m = pad dt.getMonth()
    d = pad dt.getDay()
    h = pad dt.getHours()
    m = pad dt.getMinutes()
    s = pad dt.getSeconds()
    return "#{y}/#{m}/#{d} #{h}:#{m}:#{s}"

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
    while $('#events-container > div.lg-item').length >= maxRows
      $('#events-container > div.lg-item:last-child').remove()

Meteor.subscribe '_events_type'
