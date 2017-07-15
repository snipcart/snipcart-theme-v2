var gulp = require('gulp');
var es = require('event-stream');
var sass = require('gulp-sass');
var concat = require('gulp-concat');
var minifyCss = require('gulp-minify-css');
var rename = require('gulp-rename');
var autoprefixer = require('gulp-autoprefixer');
var argv = require('yargs').option('version', {type: 'string'}).argv;
var postcss = require('gulp-postcss');
var mqpacker = require('css-mqpacker');
var browserSync = require('browser-sync');
var argv = require('yargs').argv

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

gulp.task('sass', function() {
    gulp.src(sources.sass)
        .pipe(sass().on('error', sass.logError))
        .pipe(autoprefixer({cascade: false, browsers: ['> 0.25%']}))
        .pipe(gulp.dest(workingDir));
});

gulp.task('min', ['sass'], function() {
    gulp.src(sources.compiled)
        .pipe(postcss([mqpacker]))
        .pipe(minifyCss())
        .pipe(rename({suffix: '.min'}))
        .pipe(gulp.dest(workingDir));
});

gulp.task('watch', function() {
    gulp.watch([watch.sass], ['sass']);
});

gulp.task('sync', ['dev'], function() {
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
});

gulp.task('dev', ['default', 'watch']);
gulp.task('default', ['sass']);
gulp.task('deploy', ['min'], function() {
    gulp.src([themesDir + "/**/*", '!**/*.scss', '!**/sass', '!**/styles.css'])
        .pipe(gulp.dest(getDistDir()))
});
