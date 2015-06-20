module.exports =
  '/event/.*':
    get: ['checkEvent','checkStatus']
    post: ['checkEvent','checkStatus']