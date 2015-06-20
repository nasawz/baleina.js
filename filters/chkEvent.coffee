func_event = loadService('event');
module.exports = (req, res, next) ->
  func_event.getEventById req.params.eventId, (err, data)->
    res.locals.event = data
    res.locals.referer = '#'
    res.locals.referer = req.session.referer if req.session.referer
    next()

