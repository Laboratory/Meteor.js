#Github public api
#Documentations
#https://developer.github.com/v3/activity/events/

class @GithubEvents extends Npm.require('events').EventEmitter
  #Github public events url
  _url: 'https://api.github.com/events'
  autostart: false
  interval: 5000 #ms

  #autostart - run get data from server
  constructor: (@autostart, @interval = @interval) ->
    @startReceive() if @autostart is true

  getEvents: ->
    Meteor.http.get @_url, {
        headers:
          'User-Agent': 'Meteor.js'
      }, _.bind ((status, result) ->
        return console.error status if status #stop service and see why github bloc your domain
        data = @_getData(result)
        @emit 'DataReceive', data if data.length > 0
        ), this

  _getData: (result) ->
    if result and result.data then result.data else []

  startReceive: ->
    @getEvents()
    @once "DataReceive", _.bind (data) ->
        @saveEvents data
        @_timer = Meteor.setTimeout( _.bind(->
            @startReceive() if @_timer
          , this), @interval)
      , this

  stopReceive: ->
    Meteor.clearTimeout @_timer
    delete @_timer

  saveEvents: (events) ->
    self = @
    events.forEach (event) ->
      dbEvent = Events.findOne id: event.id
      if dbEvent isnt null then Events.insert event else Events.update event
