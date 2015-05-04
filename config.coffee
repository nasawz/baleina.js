config =
  port: 8080
  restApiRoot: '/api'
  base_path: __dirname
  script_ext: '.coffee'
  assets_head: '/assets'
  session_secret: '1234567'
  rainbow:
    controllers: '/controllers/'
    filters: '/filters/'
    template: '/views/'
module.exports = config
