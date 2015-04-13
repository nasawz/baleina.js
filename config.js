  var config;

  config = {
      run_port: 8080,
      base_path: __dirname, //应用根路径，程序中常用
      script_ext: ".js", //编程用的脚本后缀
      assets_head: "/assets",
      session_secret: "1234567", //session
      //rainbow的配置
      rainbow: {
          controllers: '/controllers/',
          filters: '/filters/',
          template: '/views/'
      }
  };

  module.exports = config;