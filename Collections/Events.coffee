@Events = new Meteor.Collection 'events'
@EventsType = new Meteor.Collection 'events_type'

for collection in [@Events, @EventsType]
  collection.allow ->
    insert: ->
      false
    update: ->
      false
    remove: ->
      false
