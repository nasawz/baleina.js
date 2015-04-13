# 加载需要用到的service
# func_{{name}} = loadService('{{name}}');
module.exports =
  '/':
    get: ->
      (req, res, next) ->
        next()
        return