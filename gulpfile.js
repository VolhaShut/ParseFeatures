const gulp = require('gulp');
const util = require('gulp-util');
const finder=require('./lib/getFiles').finder;
const reader=require('./lib/readFeatures').reader;
const jiraTickets=require('./lib/rest/rest_request').getJiraTickets;
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
    let allTickets=[];
    let totalTests;
    let pr=[];
    jiraTickets(0).then((resp)=>{
        totalTests=resp.totalTests;
        allTickets.push(resp.response);
    }).then(()=>{
        let i=50;
        console.log(totalTests);
        while(i<totalTests){
            console.log("Request start at "+i);
            pr.push(jiraTickets(i).then((resp)=>{
                allTickets.push(resp.response);
            }));
            i+=50;
        }
    }).then(()=>{
       return Promise.all(pr);
    }).then(()=>{
        fs.writeFileSync('./output/response.json',JSON.stringify(allTickets),'utf8');
        console.log('done!');
    })

});

gulp.task('create-session', ()=>{
    let username=util.env.username;
    let password=util.env.password;
    fs.writeFileSync('./lib/credentials.json',JSON.stringify({"username":username, "password":password}),'utf8');
    require('./lib/rest/rest-client');
});

gulp.task('delete-session', ()=>{
    require('./lib/rest/rest-delete-session');
});
