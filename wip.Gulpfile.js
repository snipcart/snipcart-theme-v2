var gulp = require('gulp');
var FwdRef = require('undertaker-forward-reference');
var es = require('event-stream');
var sass = require('gulp-sass');
var concat = require('gulp-concat');
var cleanCSS = require('gulp-clean-css');
var rename = require('gulp-rename');
var autoprefixer = require('gulp-autoprefixer');
var argv = require('yargs').option('version', {type: 'string'}).argv;
var postcss = require('gulp-postcss');
var mqpacker = require('css-mqpacker');
var browserSync = require('browser-sync');
var argv = require('yargs').argv

gulp.registry(FwdRef());

var themesDir = 'themes';
var workingDir = 'themes/base';

var sources = {
  sass: workingDir + '/sass/snipcart.scss',
  compiled: workingDir + '/snipcart.css'
};

var watch = {
    sass: workingDir + '/sass/**/*.scss'
};

var getDistDir = function (output) {
  var dir = './dist/themes';
  if (argv.version) {
    dir = "./dist/themes/" + argv.version;
  }
  if (output) {
    dir += '/' + output;
  }
  return dir;
};

var sassTask = function() {
  return gulp.src(sources.sass)
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer({cascade: false, browsers: ['> 0.25%']}))
    .pipe(gulp.dest(workingDir));
};

var minTask = function() {
  return gulp.src(sources.compiled)
    .pipe(postcss([mqpacker]))
    .pipe(cleanCSS())
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(workingDir));
};

var watchTask = gulp.series(function(done) {
  gulp.watch([watch.sass]).on('change', function(event) {
    sassTask;
  });
  done();
});

var syncTask = gulp.series(function(done) {
  var proxy = argv.proxy ? argv.proxy : 'snipcart.client/';
  var sync = browserSync.create(proxy);
  sync.init({
    port: 3006,
    proxy: proxy,
    cors: true,
    serveStatic: ['.'],
    ui: {
      port: 3007
    }
  });
  gulp.watch(sources.compiled).on('change', sync.reload);
  done();
});

var deployTask = function() {
  return gulp.src([themesDir + "/**/*", '!**/*.scss', '!**/sass', '!**/styles.css'])
    .pipe(gulp.dest(getDistDir()));
};

gulp.task('sass',    gulp.series(sassTask));
gulp.task('min',     gulp.series('sass', minTask));
gulp.task('watch',   gulp.series(watchTask));
gulp.task('dev',     gulp.series('default', 'watch'));
gulp.task('sync',    gulp.series('dev', syncTask));
gulp.task('deploy',  gulp.series('min', deployTask));

gulp.task('default', gulp.series('sass'));
