gulp   = require 'gulp'
argv   = require('yargs').argv
gulpif = require 'gulp-if'

jade     = require 'gulp-jade'
sass     = require 'gulp-sass'
coffee   = require 'gulp-coffee'

uglify   = require 'gulp-uglify'
cssmin   = require 'gulp-cssmin'
rename   = require 'gulp-rename'
concat   = require 'gulp-concat'

livereload = require 'gulp-livereload'
watch      = require 'gulp-watch'
gutil      = require 'gulp-util'

mainBowerFiles = require 'main-bower-files'

rootdir = if argv.production then 'prod' else 'dev'

#--------- Initialization Tasks ---------------------------

# Copy bower files to the build directory.
gulp.task 'init:bower', ->

   gulp.src(mainBowerFiles('**/*.js'))
      .pipe(concat('vendor.js'))
      .pipe(gulpif(argv.production, uglify()))
      .pipe(gulpif(argv.production, rename(suffix: '.min')))
      .pipe(gulp.dest("build/#{rootdir}/js"))

   gulp.src(mainBowerFiles(['**/Roboto*.ttf', '**/Roboto*.woff*']))
      .pipe(gulp.dest("build/#{rootdir}/font/roboto"))

   gulp.src(mainBowerFiles('**/fontawesome-webfont.*'))
      .pipe(gulp.dest("build/#{rootdir}/font/font-awesome"))

   gulp.src(mainBowerFiles('**/Material-Design-Icons.*'))
      .pipe(gulp.dest("build/#{rootdir}/font/material-design-icons"))

# Copy additional resources to the build directory.
gulp.task 'init:assets', ->

   gulp.src('assets/**/*')
      .pipe(gulp.dest("build/#{rootdir}"))

# Combined initialization tasks.
gulp.task 'init', ['init:bower', 'init:assets']


#--------- Build Tasks ------------------------------------

# Build site html file from jade templates.
gulp.task 'build:jade', ->

   src = gulp.src(['src/*.jade', '!src/layout.jade', '!src/mixins.jade'])

   if argv.production
      src.pipe(jade())
         .pipe(gulp.dest("build/#{rootdir}"))
   else
      src.pipe(jade(
            pretty: true
            locals:
               development: true
         ))
         .pipe(gulp.dest("build/#{rootdir}"))
         .pipe(livereload())


# Build site javascript from coffeescript files.
gulp.task 'build:coffee', ->

   src = gulp.src('src/site.coffee')
      .pipe(coffee(bare: true).on('error', gutil.log))

   if argv.production
      src.pipe(uglify())
         .pipe(rename(suffix: '.min'))
         .pipe(gulp.dest("build/#{rootdir}/js"))
   else
      src.pipe(gulp.dest("build/#{rootdir}/js"))
         .pipe(livereload())

# Build site css file from SASS files.
gulp.task 'build:scss', ->

   src = gulp.src('src/styles/*.scss')
      .pipe(sass())

   if argv.production
      src.pipe(cssmin())
         .pipe(rename(suffix: '.min'))
         .pipe(gulp.dest("build/#{rootdir}/css"))
   else
      src.pipe(gulp.dest("build/#{rootdir}/css"))
         .pipe(livereload())

# Combined build tasks.
gulp.task 'build', ['build:jade', 'build:coffee', 'build:scss']


#--------- Watch and Default Tasks ------------------------

# Setup file watchers.
gulp.task 'watch', ->
   gulp.watch 'src/**/*.jade',          ['build:jade']
   gulp.watch 'src/**/*.coffee',        ['build:coffee']
   gulp.watch 'src/styles/**/*.scss',   ['build:scss']

   # Start the live reload server.
   livereload.listen()


# Run all tasks by default and begin watching for file changes.
gulp.task 'default', ['init', 'build', 'watch']
