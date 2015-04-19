//框架主脚本
require('./baleina/BaseInit.js')

//初始化express
var express = require('express');
var config = require('./config.js');
module.exports = app = express();

var ExpressInit = require("./baleina/ExpressInit.js");
ExpressInit(app);