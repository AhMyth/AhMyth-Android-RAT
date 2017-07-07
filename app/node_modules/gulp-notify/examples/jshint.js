var jshint = require('gulp-jshint');
var notify = require('gulp-notify');
var gulp = require('gulp');

gulp.task('lint', function() {
  gulp.src('/src/**/*.js')
    .pipe(jshint())
    // Use gulp-notify as jshint reporter
    .pipe(notify(function (file) {
      if (file.jshint.success) {
        // Don't show something if success
        return false;
      }

      var errors = file.jshint.results.map(function (data) {
        if (data.error) {
          return "(" + data.error.line + ':' + data.error.character + ') ' + data.error.reason;
        }
      }).join("\n");
      return file.relative + " (" + file.jshint.results.length + " errors)\n" + errors;
    }));
});

gulp.task('watch', ['lint'], function() {
  gulp.watch('/src/**/*.js', ['lint']);
});

gulp.task('default', ['lint']);
