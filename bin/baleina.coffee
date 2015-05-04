util = require('util')
fse = require('fs-extra')
path = require('path')
shellby = require('shellby')

tumo =
  create: ->
    cliPath = path.resolve('.')
    folders = [
      'assets'
      'controllers'
      'filters'
      'server'
      'services'
      'tumo'
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



module.exports = tumo