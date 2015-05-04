module.exports =
  '/dog*':
    get: [ 'chkDog' ]
    post: [ 'chkDog' ]