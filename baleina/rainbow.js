var approot = process.env.PWD;
var glob = require('glob');
var methods = require('methods');
var fs = require('fs');
var BaseController = require('./BaseController.js')
config = require('./../config.js');
/**
 * Main function to initialize routers of a Express app.
 *
 * @param  {Express} app  Express app instance
 * @param  {Object} paths (optional) For configure relative paths of
 *                        controllers and filters rather than defaults.
 */
exports.route = function(app, paths) {


    paths = paths || {};
    app.set('views', config.base_path + paths.template);
    var ctrlDir = config.base_path + (paths.controllers || '/controllers');
    var fltrDir = config.base_path + (paths.filters || '/filters');
    var tplDir = config.base_path + (paths.template || '/templates');
    glob.sync(ctrlDir + '/**/*.+(js|coffee)').forEach(function(file) {
        file = file.replace(/\/index\.(js|coffee)$/, '');
        var router = require(file);
        var single = typeof router == 'function';
        var path = file.replace(ctrlDir.replace(/\/$/, ''), '').replace(/\.(js|coffee)$/, '');
        var tplPath = tplDir + path + '.html';
        var isTplExist = fs.existsSync(tplPath);
        var setup = function(req, res, next) {
            req.rb_path = path;
        };
        // '-----------------为windows修正path'
        path = path.replace(/.*\/controllers/,"");

        for (var i in router) {
            var p = (path + i);
            if (p != '/') {
                p = p.replace(/\/$/, '')
            }
            var r = router[i];
            methods.forEach(function(method) {
                var eachRouter = r[method];
                if (eachRouter) {

                    var controller = new BaseController(app, eachRouter, p.replace(/^\//, ''), method);

                    if (controller.newName) {
                        console.log('controller.newName',controller.newName)
                        p = p.replace(controller.name, controller.newName);
                        console.log("route:" + method + ':' + p)
                        app[method].apply(app, [p].concat(controller.getRoutes()));
                    } else {
                        console.log("route:" + method + ':' + p)
                        app[method].apply(app, [p].concat(controller.getRoutes()));
                    }

                }
            });
        }

    });
};