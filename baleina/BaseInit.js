var config, path;
config = require('./../config.js');
path = require('path');



global.loadService = function(functionName) {
    return require(path.join(config.base_path, 'services', functionName + config.script_ext));
};
