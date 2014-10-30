Meteor.startup ->
  #code to run on server at startup
  #https://developer.github.com/v3/#rate-limiting
  #rate limit 60 per hour
  #user _token form 5000 request per hour
  githubEvents = new GithubEvents true, 1000

  Meteor.publish '_events', (type) ->
    Events.find {}, {limit: 20, sort: {id: -1}}

  Meteor.publish '_events_type', ->
    EventsType.find()
