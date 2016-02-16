gulp = require 'gulp'
es = require 'event-stream'
sass = require 'gulp-sass'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
argv = require('yargs').option('version', {type: 'string'}).argv

themesDir = 'themes'
workingDir = 'themes/base'
sources =
  sass: "#{workingDir}/sass/snipcart.scss"
  css: "#{workingDir}/styles.css"
  compiled: "#{workingDir}/snipcart.css"

getDistDir = (output)->
  dir = './dist/themes'

  if argv.version
    dir = "./dist/themes/#{argv.version}"

  if output
    dir += "/#{output}"

  return dir

gulp.task 'sass', ->
  scss = gulp.src(sources.sass)
    .pipe(sass())

  css = gulp.src(sources.css)

  es.merge(css, scss)
    .pipe(concat('snipcart.css'))
    .pipe(gulp.dest('themes/base'))

gulp.task 'min', ['sass'], ->
  gulp.src(sources.compiled)
    .pipe(minifyCss())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(workingDir))

gulp.task 'watch', ->
    gulp.watch [sources.sass, sources.css], ['sass']

gulp.task 'default', ['watch']
gulp.task 'deploy', ['min'], ->
  gulp.src(["#{themesDir}/**/*", '!**/*.scss', '!**/sass', '!**/styles.css'])
    .pipe(gulp.dest(getDistDir()))
