func_event = loadService('event');
pkg = require('../package.json')
func_eventExt = loadService('eventExt');

module.exports = (req, res, next) ->
  res.locals.event = {id:'0'}
  res.locals.referer = '#'
  res.locals.pkg = pkg
  return next()
#  ep = EventProxy.create 'event','ext', (event,ext)->
#    res.locals.event = event
#    res.locals.referer = '#'
#    res.locals.referer = req.session.referer if req.session.referer
#    res.locals.version = pkg.version
#    res.locals.eventExt = ext
#    return next()
#  func_event.getEventById req.params.eventId, (err, data)->
#    ep.emit 'event',data
#  func_eventExt.getEventExtById req.params.eventId, (err, data)->
#    ep.emit 'ext',data
