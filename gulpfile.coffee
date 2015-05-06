gulp = require 'gulp'

jade     = require 'gulp-jade'
sass     = require 'gulp-sass'
coffee   = require 'gulp-coffee'

livereload = require 'gulp-livereload'
watch      = require 'gulp-watch'
gutil      = require 'gulp-util'

mainBowerFiles = require 'main-bower-files'


#--------- Initialization Tasks ---------------------------

# Copy bower files to the build directory.
gulp.task 'init:bower', ->

   gulp.src(mainBowerFiles('**/*.js'))
      .pipe(gulp.dest('build/vendor/js'))

   gulp.src(mainBowerFiles('**/*.css'))
      .pipe(gulp.dest('build/vendor/css'))

   gulp.src(mainBowerFiles(['**/Roboto*.ttf', '**/Roboto*.woff*']))
      .pipe(gulp.dest('build/vendor/font/roboto'))

   gulp.src(mainBowerFiles('**/fontawesome-webfont.*'))
      .pipe(gulp.dest('build/vendor/fonts'))

   gulp.src(mainBowerFiles('**/Material-Design-Icons.*'))
      .pipe(gulp.dest('build/vendor/font/material-design-icons'))

# Copy additional resources to the build directory.
gulp.task 'init:assets', ->

   gulp.src('assets/**/*')
      .pipe(gulp.dest('build'))

# Combined initialization tasks.
gulp.task 'init', ['init:bower', 'init:assets']


#--------- Build Tasks ------------------------------------

# Build site html file from jade templates.
gulp.task 'build:jade', ->

   gulp.src(['src/index.jade', 'src/thank-you.jade'])
      .pipe(jade(pretty: true))
      .pipe(gulp.dest('build'))
      .pipe(livereload())

# Build site javascript from coffeescript files.
gulp.task 'build:coffee', ->

   gulp.src('src/site.coffee')
      .pipe(coffee(bare: true).on('error', gutil.log))
      .pipe(gulp.dest('build'))
      .pipe(livereload())

# Build site css file from SASS files.
gulp.task 'build:scss', ->

   gulp.src('src/*.scss')
      .pipe(sass())
      .pipe(gulp.dest('build'))
      .pipe(livereload())

# Combined build tasks.
gulp.task 'build', ['build:jade', 'build:coffee', 'build:scss']


#--------- Watch and Default Tasks ------------------------

# Setup file watchers.
gulp.task 'watch', ->
   gulp.watch 'src/**/*.jade',   ['build:jade']
   gulp.watch 'src/**/*.coffee', ['build:coffee']
   gulp.watch 'src/**/*.scss',   ['build:scss']

   # Start the live reload server.
   livereload.listen()


# Run all tasks by default and begin watching for file changes.
gulp.task 'default', ['init', 'build', 'watch']
