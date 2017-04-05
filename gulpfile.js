const gulp = require('gulp');
const util = require('gulp-util');
const finder=require('./getFiles').finder;
const reader=require('./readFeatures').reader;


gulp.task('read:features', ()=>{
    let dirname=util.env.path;
    reader(finder(dirname));

});

gulp.task('post:jira', ()=>{
    require('./rest_request');
});

gulp.task('create-session', ()=>{
    require('./rest-client');
});

gulp.task('delete-session', ()=>{
    require('./rest-delete-session');
});
