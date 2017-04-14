const gulp = require('gulp');
const util = require('gulp-util');
const finder=require('./lib/getFiles').finder;
const reader=require('./lib/readFeatures').reader;
const path=require('path');
const fs=require('fs');


gulp.task('read:features', ()=>{
    let dirname=path.normalize(util.env.path);
    let files=finder(dirname);
    reader(files).then((features)=>{
        fs.writeFileSync('./output/features.json',JSON.stringify(features),'utf8');
        console.log('done!');
    });
});

gulp.task('post:jira', ()=>{
    require('./lib/rest/rest_request');
});

gulp.task('create-session', ()=>{
    require('./lib/rest/rest-client');
});

gulp.task('delete-session', ()=>{
    require('./lib/rest/rest-delete-session');
});
