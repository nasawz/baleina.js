# 加载需要用到的service
#func_{{name}} = loadService('{{name}}');

module.exports = (req, res, next) ->
  # console.log('filter {{name}}')
  next()