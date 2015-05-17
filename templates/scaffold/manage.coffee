func_event = loadService('event');
module.exports =
  '/:eventId':
    get:->
      (req, res, next)->
          res.render('manage/index')