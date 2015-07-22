
module.exports = (require 'nconf').argv().env()
  .defaults {
    port: 8080
    logger:
      name: 'front-end'
      file: 'log/scooter-travel.log'
  }
