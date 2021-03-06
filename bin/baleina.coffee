util = require('util')
fse = require('fs-extra')
path = require('path')
shellby = require('shellby')
_ = require('underscore')
ejs = require('ejs')
#ejs.open = '{{'
#ejs.close = '}}'

baleina =
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
    modelInstance = model.substr(0,1).toLowerCase()+model.substr(1,model.length)
    console.log 'modelInstance',modelInstance
    cliPath = path.resolve('.')
    content = fse.readFileSync(path.join(__dirname, '../templates/scaffold/service.templete'))


    content = content.toString().replace(/\{\{modelInstance\}\}/g, modelInstance)
    content = content.toString().replace(/\{\{modelClass\}\}/g, modelClass)

    dirPath = path.join(cliPath, 'services')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'services', '_'+modelInstance+'.coffee')
    fse.writeFileSync file, content, 'utf-8'
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
      ['templates/scaffold/model/event-ext.js','common/models/event-ext.js']
      ['templates/scaffold/model/event-ext.json','common/models/event-ext.json']
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
      ['templates/scaffold/eventExt.coffee','services/eventExt.coffee']
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



  scaffoldModel:(model) ->
    cliPath = path.resolve('.')
    modelConfig = require(path.join(cliPath, 'common/models', model + '.json'))

    model_ab = modelConfig.name.toLowerCase().replace(/-/g, '')
    model_arr = modelConfig.name.toLowerCase().split('-')
    model_aB = model_ab
    model_aB = model_arr[0]+model_arr[1].substr(0,1).toLocaleUpperCase()+model_arr[1].substr(1,model_arr[1].length) if model_arr.length > 1
    model_AB = model_aB.substr(0,1).toLocaleUpperCase()+model_aB.substr(1,model_aB.length)


    console.log model_ab,model_aB,model_AB


    this.scaffoldService(model_AB)
    this.scaffoldModel_model_create_controllerr(modelConfig)
    this.scaffoldModel_model_list_controllerr(modelConfig)
    this.scaffoldModel_model_create_view(modelConfig)
    this.scaffoldModel_model_list_view(modelConfig)
    console.log('act succ')

  scaffoldSidebar:() ->
    cliPath = path.resolve('.')
    modelConfig = require(path.join(cliPath, 'server', 'model-config.json'))
    this.scaffoldSidebar_view(modelConfig)
    console.log('act succ')

  scaffoldSetting:() ->
    cliPath = path.resolve('.')
    modelConfig = require(path.join(cliPath, 'common/models', 'event-ext.json'))
    this.scaffold_setting_view(modelConfig)
    this.scaffold_setting_controllerr(modelConfig)
    console.log('act succ')

  scaffoldSidebar_view:(modelConfig)->
    cliPath = path.resolve('.')
    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/sidebar.view')).toString()
    content = ejs.render template, modelConfig:modelConfig
    content = content.toString().replace(/\{\{/g, '<%')
    content = content.toString().replace(/\}\}/g, '%>')
    dirPath = path.join(cliPath, 'views/manage','inc')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'views/manage','inc','_sidebar.html')
    fse.writeFileSync file, content, 'utf-8'

  scaffold_setting_view:(modelConfig)->
    cliPath = path.resolve('.')
    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/setting.view')).toString()
    content = ejs.render template, modelConfig:modelConfig
    content = content.toString().replace(/\{\{/g, '<%')
    content = content.toString().replace(/\}\}/g, '%>')
    dirPath = path.join(cliPath, 'views/manage','setting')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'views/manage','setting','_index.html')
    fse.writeFileSync file, content, 'utf-8'

  scaffold_setting_controllerr:(modelConfig)->
    cliPath = path.resolve('.')
    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/setting.controller')).toString()
    content = ejs.render template, modelConfig:modelConfig
    dirPath = path.join(cliPath, 'controllers/manage','setting')
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'controllers/manage','setting','index._coffee')
    fse.writeFileSync file, content, 'utf-8'


  scaffoldModel_model_create_view:(modelConfig)->
    cliPath = path.resolve('.')
    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/model_create.view')).toString()
    content = ejs.render template, modelConfig:modelConfig
    content = content.toString().replace(/\{\{/g, '<%')
    content = content.toString().replace(/\}\}/g, '%>')
    dirPath = path.join(cliPath, 'views/manage',modelConfig.name.toLowerCase().replace(/-/g, ''))
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'views/manage',modelConfig.name.toLowerCase().replace(/-/g, ''),'_create.html')
    fse.writeFileSync file, content, 'utf-8'

  scaffoldModel_model_list_view:(modelConfig)->
    cliPath = path.resolve('.')
    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/model_list.view')).toString()
    content = ejs.render template, modelConfig:modelConfig
    content = content.toString().replace(/\{\{/g, '<%')
    content = content.toString().replace(/\}\}/g, '%>')
    dirPath = path.join(cliPath, 'views/manage',modelConfig.name.toLowerCase().replace(/-/g, ''))
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'views/manage',modelConfig.name.toLowerCase().replace(/-/g, ''),'_index.html')
    fse.writeFileSync file, content, 'utf-8'


  scaffoldModel_model_list_controllerr:(modelConfig)->
    cliPath = path.resolve('.')
    model_ab = modelConfig.name.toLowerCase().replace(/-/g, '')
    model_arr = modelConfig.name.toLowerCase().split('-')
    model_aB = model_ab
    model_aB = model_arr[0]+model_arr[1].substr(0,1).toLocaleUpperCase()+model_arr[1].substr(1,model_arr[1].length) if model_arr.length > 1
    model_AB = model_aB.substr(0,1).toLocaleUpperCase()+model_aB.substr(1,model_aB.length)

    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/model_list.controller')).toString()
    content = ejs.render template, modelConfig:modelConfig,model_ab:model_ab,model_aB:model_aB,model_AB:model_AB
    dirPath = path.join(cliPath, 'controllers/manage',modelConfig.name.toLowerCase().replace(/-/g, ''))
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'controllers/manage',modelConfig.name.toLowerCase().replace(/-/g, ''),'index._coffee')
    fse.writeFileSync file, content, 'utf-8'

  scaffoldModel_model_create_controllerr:(modelConfig)->
    cliPath = path.resolve('.')
    model_ab = modelConfig.name.toLowerCase().replace(/-/g, '')
    model_arr = modelConfig.name.toLowerCase().split('-')
    model_aB = model_ab
    model_aB = model_arr[0]+model_arr[1].substr(0,1).toLocaleUpperCase()+model_arr[1].substr(1,model_arr[1].length) if model_arr.length > 1
    model_AB = model_aB.substr(0,1).toLocaleUpperCase()+model_aB.substr(1,model_aB.length)

    template = fse.readFileSync(path.join(__dirname, '../templates/scaffold/views/model_create.controller')).toString()
    content = ejs.render template, modelConfig:modelConfig,model_ab:model_ab,model_aB:model_aB,model_AB:model_AB
    dirPath = path.join(cliPath, 'controllers/manage',modelConfig.name.toLowerCase().replace(/-/g, ''))
    fse.ensureDirSync dirPath
    file = path.join(cliPath, 'controllers/manage',modelConfig.name.toLowerCase().replace(/-/g, ''),'create._coffee')
    fse.writeFileSync file, content, 'utf-8'


module.exports = baleina