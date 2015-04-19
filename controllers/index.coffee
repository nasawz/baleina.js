module.exports =

  '/': get: ->
    (req, res, next) ->
      res.send 'Hello baleina.js!'