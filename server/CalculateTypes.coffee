Meteor.methods do ->
  calculateTypes: (type) ->
    row = EventsType.findOne(type: type)
    unless row
      EventsType.insert
        type: type
        count: 1
    else
      row.count += 1
      EventsType.update row._id, row

count = @Events.find().count()

@Events.find().observe do ->
  addedAt: (doc, atIndex)->
    Meteor.call 'calculateTypes', doc.type if atIndex > count
