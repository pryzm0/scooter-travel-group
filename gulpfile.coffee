
gulp = require 'gulp'
server = require 'gulp-develop-server'
jade = require 'gulp-jade'
coffee = require 'gulp-coffee'
gulpif = require 'gulp-if'

paths =
  server: 'index.js'
  app: ['app/**/*.js', 'app/**/*.coffee']
  public: 'www_public/'
  templates: ['www/**/*.jade']
  scripts: ['www/**/*.js', 'www/**/*.coffee']
  styles: ['www/**/*.css']

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

gulp.task 'scripts', ->
  gulp.src(paths.scripts)
    .pipe(gulpif /coffee$/, coffee())
    .pipe(gulp.dest paths.public)

gulp.task 'styles', ->
  gulp.src(paths.styles)
    .pipe(gulp.dest paths.public)

gulp.task 'build', ['templates', 'scripts', 'styles']

gulp.task 'watch', ['build'], ->
  gulp.watch paths.templates, ['templates']
  gulp.watch paths.scripts, ['scripts']
  gulp.watch paths.styles, ['styles']

gulp.task 'default', ['watch', 'server']
