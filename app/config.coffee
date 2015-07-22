
module.exports = (require 'nconf').argv().env()
  .defaults {
    port: 8080
    admin: true
    static: true
    logger:
      name: 'front-end'
      file: 'log/scooter-travel.log'
  }
