gulp = require 'gulp'

jade     = require 'gulp-jade'
sass     = require 'gulp-sass'
coffee   = require 'gulp-coffee'

livereload = require 'gulp-livereload'
watch      = require 'gulp-watch'
gutil      = require 'gulp-util'

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

gulp.task 'build:coffee', ->

   gulp.src('src/site.coffee')
      .pipe(coffee(bare: true).on('error', gutil.log))
      .pipe(gulp.dest('build'))
      .pipe(livereload())

gulp.task 'build:scss', ->
   gulp.src('src/*.scss')
      .pipe(sass())
      .pipe(gulp.dest('build'))
      .pipe(livereload())

gulp.task 'build', ['build:jade', 'build:coffee', 'build:scss']


gulp.task 'watch', ->
   gulp.watch 'src/**/*.jade',   ['build:jade']
   gulp.watch 'src/**/*.coffee', ['build:coffee']
   gulp.watch 'src/**/*.scss',   ['build:scss']

   livereload.listen()


gulp.task 'default', ['init', 'build', 'watch']
