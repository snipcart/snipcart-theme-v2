gulp = require 'gulp'
FwdRef = require 'undertaker-forward-reference'
es = require 'event-stream'
sass = require 'gulp-sass'
concat = require 'gulp-concat'
cleanCSS = require 'gulp-clean-css'
rename = require 'gulp-rename'
autoprefixer = require 'gulp-autoprefixer'
postcss = require 'gulp-postcss'
mqpacker = require 'css-mqpacker'
browserSync = require 'browser-sync'
argv = require('yargs').argv

gulp.registry(FwdRef())

themesDir = 'themes'
workingDir = 'themes/base'

sources =
  sass: "#{workingDir}/sass/snipcart.scss"
  compiled: "#{workingDir}/snipcart.css"

watch =
  sass: "#{workingDir}/sass/**/*.scss"

getDistDir = (output)->
  version = "2.0"
  dir = './dist/themes'
  if version
    dir = "./dist/themes/#{version}"
  if output
    dir += "/#{output}"
  return dir

sassTask = () ->
  return gulp.src sources.sass
    .pipe(sass().on('error', sass.logError))
    .pipe autoprefixer(cascade: false, browsers: ['> 0.25%'])
    .pipe gulp.dest(workingDir)

minTask = () ->
  return gulp.src sources.compiled
    .pipe(postcss([mqpacker]))
    .pipe(cleanCSS())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(workingDir))

watchTask = gulp.series (done) ->
  gulp.watch([watch.sass]).on 'change', sassTask
  done()

syncTask = gulp.series (done) ->
  proxy = argv.proxy ? 'snipcart.client/'
  sync = browserSync.create proxy
  sync.init
    port: 3006
    proxy: proxy
    serveStatic: ['.']
    ui:
      port: 3007
  gulp.watch(sources.compiled).on 'change', sync.reload
  done()

deployTask = () ->
  return gulp.src(["#{themesDir}/**/*", '!**/*.scss', '!**/sass', '!**/styles.css'])
    .pipe(gulp.dest(getDistDir()))

gulp.task 'sass',    gulp.series(sassTask)
gulp.task 'min',     gulp.series('sass', minTask)
gulp.task 'watch',   gulp.series(watchTask)
gulp.task 'dev',     gulp.series('default', 'watch')
gulp.task 'sync',    gulp.series('dev', syncTask)
gulp.task 'deploy',  gulp.series('min', deployTask)

gulp.task 'default', gulp.series('sass')
