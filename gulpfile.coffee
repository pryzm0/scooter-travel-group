
gulp = require 'gulp'
server = require 'gulp-develop-server'
jade = require 'gulp-jade'

paths =
  server: 'index.js'
  public: 'www_public/'
  app: ['server/**/*.js']
  templates: ['www/**/*.jade']

gulp.task 'server:start', ->
  server.listen path: paths.server

gulp.task 'server:restart', ->
  server.restart()

gulp.task 'server', ['server:start'], ->
  gulp.watch paths.app, ['server:restart']

gulp.task 'templates', ->
  gulp.src(paths.templates)
    .pipe(jade())
    .pipe(gulp.dest paths.public)

gulp.task 'build', ['templates']

gulp.task 'default', ['build', 'server:start'], ->
  gulp.watch paths.templates, ['templates']
  gulp.watch paths.app, ['server:restart']
