# 加载需要用到的service
#func_dog = loadService('dog');

module.exports =
  getDogById: (id, cb) ->
    # req dog api return dog
    dog = {
      name:'bov'
    }
    cb(null,dog)
