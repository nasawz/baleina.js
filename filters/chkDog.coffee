# 加载需要用到的service
func_dog = loadService('dog');

module.exports = (req, res, next) ->
  # console.log('filter chkDog')
  func_dog.getDogById '1', (err, dog) ->
    res.locals.dog = dog
    next()