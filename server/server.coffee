Meteor.startup ->
  #code to run on server at startup
  githubEvents = new GithubEvents true, 5*1000

  Meteor.publish '_events', (type) ->
    Events.find {}, {limit: 20, sort: {id: -1}}

  Meteor.publish '_events_type', ->
    EventsType.find()
