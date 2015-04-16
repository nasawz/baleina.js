var app, config, express, http, log4js, path, rainbow;
http = require('http');

path = require('path');

config = require('./../config.js');

rainbow = require('./rainbow.js');


log4js = require('log4js');
express = require('express');
module.exports = function (app) {
    //app.configure(function() {
    var logger;
    app.set('port', config.run_port);
    //模板所在路径
    app.set('views', path.join(config.base_path, 'views'));

    app.engine('.html', require('ejs').renderFile);
    app.set('view engine', 'html');

    app.use(express.favicon());


    app.use('/assets', express['static'](config.base_path + '/assets'));
    //日志支持
    //log4js.configure({
    //    appenders: [{
    //        type: 'console'
    //    }]
    //});
    //console log is loaded by default, so you won't normally need to do this

    //log4js.loadAppender('file');
    //log4js.addAppender(log4js.appenders.file(config.base_path+'/logs/cheese.log'), 'cheese');
    log4js.loadAppender('console');
    logger = log4js.getLogger('baleina');
    logger.setLevel('INFO');

    //var logger = log4js.getLogger('cheese');
    //logger.setLevel('ERROR');

    //logger.trace('Entering cheese testing');
    //logger.debug('Got cheese.');
    //logger.info('Cheese is Gouda.');
    //logger.warn('Cheese is quite smelly.');
    //logger.error('Cheese is too ripe!');
    //logger.fatal('Cheese was breeding ground for listeria.');


    app.use(log4js.connectLogger(logger, {
        level: log4js.levels.INFO
    }));


    app.use(express.bodyParser());

    app.use(express.cookieParser());
    app.use(express.cookieSession({
        secret: config.session_secret
    }));
    app.use(express.methodOverride());


    app.use(express.cookieParser());
    app.use(express.cookieSession({
        secret: config.session_secret
    }));
    var methodOverride = require('method-override')
    app.use(methodOverride('X-HTTP-Method-Override'))

    //rainbow配置
    rainbow.route(app, config.rainbow);
    //404处理
    app.all('*', function (req, res, next) {
        return res.render('404.html');
    });
    //所有错误的集中处理，在任何route中调用next(error)即可进入此逻辑
    app.use(function (err, req, res, next) {
        console.trace(err);
        return res.render('502.html', {
            error: err
        });
    });
    //给模板引擎设置默认函数，例如时间显示moment
    app.locals.moment = require('moment');
    app.locals.moment.locale('zh-cn');
    //静态资源头，本地开发用本地，线上可以用cdn
    app.locals.assets_head = config.assets_head;
    //});

    //app.configure('development', function() {
    //    app.use(express.errorHandler());
    //    app.use(express.logger('dev'));
    //});
}
