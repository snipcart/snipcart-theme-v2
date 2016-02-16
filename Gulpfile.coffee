gulp = require 'gulp'
es = require 'event-stream'
sass = require 'gulp-sass'
concat = require 'gulp-concat'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
argv = require('yargs').argv

sources =
  sass: 'themes/base/sass/snipcart.scss'
  css: 'themes/base/styles.css'

getDistDir = (output)->
  dir = './dist/themes/base'

  if argv.version
    dir = "./dist/themes/#{argv.version}/base"

  if output
    dir += "/#{output}"

  return dir

compiled =
  dir: './dist/themes/base'
  css: './dist/themes/base/snipcart.css'

gulp.task 'sass', ->
  scss = gulp.src(sources.sass)
    .pipe(sass())

  css = gulp.src(sources.css)

  es.merge(css, scss)
    .pipe(concat('snipcart.css'))
    .pipe(gulp.dest('themes/base'))

gulp.task 'min', ['sass'], ->
  gulp.src('./themes/base/snipcart.css')
    .pipe(minifyCss())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(getDistDir()))

gulp.task 'watch', ->
    gulp.watch [sources.sass, sources.css], ['sass']

gulp.task 'default', ['watch']
gulp.task 'deploy', ['min']
