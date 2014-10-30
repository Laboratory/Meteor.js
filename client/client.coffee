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
