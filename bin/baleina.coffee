util = require('util')
fse = require('fs-extra')
path = require('path')
shellby = require('shellby')
_ = require('underscore')


tumo =
  create: ->
    cliPath = path.resolve('.')
    folders = [
      'assets'
      'controllers'
      'filters'
      'server'
      'services'
      'baleina'
      'views'
      'config.coffee'
      'filters.config.coffee'
      'index.coffee'
      'server.js'
    ]
    folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder)
      targetPath = path.join(cliPath, folder)
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    #copy package.json
    _path = path.join(__dirname, '..', 'templates/package.json')
    targetPath = path.join(cliPath, 'package.json')
    fse.copy _path, targetPath, (e) ->
      if e
        console.log 'copy file error:' + e
      return
    #copy readme.json
    _path = path.join(__dirname, '..', 'templates/README.md')
    targetPath = path.join(cliPath, 'README.md')
    fse.copy _path, targetPath, (e) ->
      if e
        console.log 'copy file error:' + e
      return
    console.log 'do npm install'
    shellby.exec 'npm install', (err) ->
      console.log 'create success!'


  createController: (name, xpath)->
    cliPath = path.resolve('.')
    content = fse.readFileSync(path.join(__dirname, '../templates/controller.coffee'))
    content = content.toString().replace(/\{\{name\}\}/g, name)
    dirPath = path.join(cliPath, 'controllers', xpath)
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'controllers', xpath, name + '.coffee')
    fse.writeFileSync file, content, 'utf-8'
    console.log('act succ')

  createView: (name, xpath)->
    cliPath = path.resolve('.')
    content = fse.readFileSync(path.join(__dirname, '../templates/view.html'))
    content = content.toString().replace(/\{\{name\}\}/g, name)
    dirPath = path.join(cliPath, 'views', xpath)
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'views', xpath, name + '.html')
    fse.writeFileSync file, content, 'utf-8'
    console.log('act succ')

  createService: (name)->
    cliPath = path.resolve('.')
    content = fse.readFileSync(path.join(__dirname, '../templates/service.coffee'))
    content = content.toString().replace(/\{\{name\}\}/g, name)
    dirPath = path.join(cliPath, 'services')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'services', name + '.coffee')
    fse.writeFileSync file, content, 'utf-8'
    console.log('act succ')

  createFilter: (name)->
    cliPath = path.resolve('.')
    content = fse.readFileSync(path.join(__dirname, '../templates/filter.coffee'))
    content = content.toString().replace(/\{\{name\}\}/g, name)
    dirPath = path.join(cliPath, 'filters')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'filters', name + '.coffee')
    fse.writeFileSync file, content, 'utf-8'
    console.log('act succ')

  scaffoldService:(model) ->
    modelClass = model
    modelInstance = model.toLowerCase()


    cliPath = path.resolve('.')
    content = fse.readFileSync(path.join(__dirname, '../templates/scaffold/service.tmplete'))
    content = content.toString().replace(/\{\{modelClass\}\}/g, modelClass)
    content = content.toString().replace(/\{\{modelInstance\}\}/g, modelInstance)

    dirPath = path.join(cliPath, 'services')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'services', '_'+modelInstance+'.coffee')
    fse.writeFileSync file, content, 'utf-8'
    console.log modelClass,modelInstance
    console.log('act succ')

  scaffoldManage: ->
    cliPath = path.resolve('.')
    #复制素材文件
    assets_folders = [
      ['templates/scaffold/fileupload','assets/fileupload']
      ['templates/scaffold/pages','assets/pages']
      ['templates/scaffold/templete','assets/templete']
      ['templates/scaffold/favicon.ico','assets/favicon.ico']
    ]
    assets_folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder[0])
      targetPath = path.join(cliPath, folder[1])
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    #复制数据模型
    model_folders = [
      ['templates/scaffold/model/event.js','common/models/event.js']
      ['templates/scaffold/model/event.json','common/models/event.json']
      ['templates/scaffold/model/model-config.json','server/model-config.json']
    ]
    model_folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder[0])
      targetPath = path.join(cliPath, folder[1])
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    #复制service
    services_folders = [
      ['templates/scaffold/event.coffee','services/event.coffee']
    ]
    services_folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder[0])
      targetPath = path.join(cliPath, folder[1])
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    #复制filter
    filters_folders = [
      ['templates/scaffold/chkEvent.coffee','filters/chkEvent.coffee']
      ['templates/scaffold/chkPin.coffee','filters/chkPin.coffee']
      ['templates/scaffold/filters.config.coffee','filters.config.coffee']
    ]
    filters_folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder[0])
      targetPath = path.join(cliPath, folder[1])
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    #复制controller
    controllers_folders = [
      ['templates/scaffold/manage.coffee','controllers/manage/index.coffee']
    ]
    controllers_folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder[0])
      targetPath = path.join(cliPath, folder[1])
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    #复制view
    views_folders = [
      ['templates/scaffold/manage','views/manage']
    ]
    views_folders.forEach (folder) ->
      _path = path.join(__dirname, '..', folder[0])
      targetPath = path.join(cliPath, folder[1])
      if fse.existsSync(_path)
        #copy整个目录过去
        fse.copy _path, targetPath, (e) ->
          if e
            console.log 'copy file error:' + e.message
          return
      return
    console.log 'auto manage complete'



module.exports = tumo