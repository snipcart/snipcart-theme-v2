gulp = require 'gulp'
es = require 'event-stream'
sass = require 'gulp-sass'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
autoprefixer = require 'gulp-autoprefixer'
argv = require('yargs').option('version', {type: 'string'}).argv
postcss = require 'gulp-postcss'
mqpacker = require 'css-mqpacker'
browserSync = require 'browser-sync'

themesDir = 'themes'
workingDir = 'themes/base'

sources =
  sass: "#{workingDir}/sass/snipcart.scss"
  compiled: "#{workingDir}/snipcart.css"

watch =
  sass: "#{workingDir}/sass/**/*.scss"

getDistDir = (output)->
  dir = './dist/themes'
  if argv.version
    dir = "./dist/themes/#{argv.version}"
  if output
    dir += "/#{output}"
  return dir

gulp.task 'sass', ->
  gulp.src sources.sass
    .pipe(sass().on('error', sass.logError))
    .pipe autoprefixer(cascade: false, browsers: ['> 1%'])
    .pipe gulp.dest(workingDir)

gulp.task 'min', ['sass'], ->
   gulp.src sources.compiled
    .pipe(postcss([mqpacker]))
    .pipe(minifyCss())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(workingDir))

  gulp.src(sources.compiled)
    .pipe(minifyCss())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(workingDir))

gulp.task 'watch', ->
  gulp.watch [watch.sass], ['sass']

gulp.task 'browser-sync', ->
  sync = browserSync.create 'snipcart.client/'
  sync.init
    port: 3005
    proxy: 'snipcart.client/'
    serveStatic: ['.']
    ui:
        port: 3006
  gulp.watch(sources.compiled).on 'change', sync.reload

gulp.task 'default', ['sass', 'watch', 'browser-sync']
gulp.task 'deploy', ['min'], ->
  gulp.src(["#{themesDir}/**/*", '!**/*.scss', '!**/sass', '!**/styles.css'])
    .pipe(gulp.dest(getDistDir()))
