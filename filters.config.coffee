module.exports =
  '/event/.*':
    get: ['checkEvent','checkStatus']
    post: ['checkEvent','checkStatus']
  '/dog*':
    get: [ 'chkDog' ]
    post: [ 'chkDog' ]