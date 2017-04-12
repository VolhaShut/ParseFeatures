const gulp = require('gulp');
const util = require('gulp-util');
const finder=require('./getFiles').finder;
const reader=require('./readFeatures').reader;
const path=require('path');
const fs=require('fs');


gulp.task('read:features', ()=>{
    let dirname=path.normalize(util.env.path);
    let files=finder(dirname);
    reader(files).then((features)=>{
        fs.writeFileSync('features.json',JSON.stringify(features),'utf8');
        console.log('done');
    })


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
