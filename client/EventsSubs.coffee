class EventsSabs
  constructor: (btn)->
    @_btn = btn || $ '<button></button>'
    @_btn.on 'click', _.bind @_click, this
    @start()

  _click: ->
    unless @subs then @start() else @stop()

  start: ->
    @subs = Meteor.subscribe '_events' unless @subs

  stop: ->
    @subs && @subs.stop()
    delete @subs

$ ->
  @eventsSubs = new EventsSabs $ '#btn-sabscription'
