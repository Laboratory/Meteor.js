@Events = new Meteor.Collection 'events'
@EventsType = new Meteor.Collection 'events_type'

@Events.allow do ->
  insert: ->
    false
  update: ->
    false
  remove: ->
    false


@EventsType.allow do ->
  insert: ->
    false
  update: ->
    false
  remove: ->
    false
