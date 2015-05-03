gulp = require 'gulp'

jade     = require 'gulp-jade'

livereload = require 'gulp-livereload'
watch      = require 'gulp-watch'

mainBowerFiles = require 'main-bower-files'

gulp.task 'init:bower', ->

   gulp.src(mainBowerFiles('**/*.js'))
      .pipe(gulp.dest('build/vendor/js'))

   gulp.src(mainBowerFiles('**/*.css'))
      .pipe(gulp.dest('build/vendor/css'))

   gulp.src(mainBowerFiles(['**/Roboto*.ttf', '**/Roboto*.woff*']))
      .pipe(gulp.dest('build/vendor/font/roboto'))

   gulp.src(mainBowerFiles('**/Material-Design-Icons.*'))
      .pipe(gulp.dest('build/vendor/font/material-design-icons'))

gulp.task 'init:assets', ->
   gulp.src('assets/**/*')
      .pipe(gulp.dest('build'))


gulp.task 'init', ['init:bower', 'init:assets']


gulp.task 'build:jade', ->

   gulp.src('src/index.jade')
      .pipe(jade(pretty: true))
      .pipe(gulp.dest('build'))
      .pipe(livereload())

gulp.task 'build:css', ->
   gulp.src('src/*.css')
      .pipe(gulp.dest('build'))
      .pipe(livereload())

gulp.task 'build', ['build:jade', 'build:css']


gulp.task 'watch', ->
   gulp.watch 'src/**/*.jade', ['build:jade']
   gulp.watch 'src/**/*.css',  ['build:css']

   livereload.listen()


gulp.task 'default', ['init', 'build', 'watch']
