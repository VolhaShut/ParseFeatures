const rp=require('request-promise'); //import
const fs=require('fs');
const cookie_session=require('./../credentials.json');
const path=require('path');
const options = {
    method: 'POST',
    uri: 'https://jira.wolterskluwer.io/jira/rest/api/2/search?jql=project%20%3D%20CU%20AND%20type%20%3D%20Test%20AND%20labels%20%3D%20Automated',
    body: {
    },
    headers: {
        // Set the cookie from the session information
        cookie: cookie_session.session,
        "Content-Type": "application/json"
    },
    json: true // Automatically parses the JSON string in the response
};

function getObj(repos) {
    return repos;
}

function writeObj(repos){
    fs.writeFile(
        path.normalize('./output/response.json'),
        JSON.stringify(repos),
        function(){
           console.log("Ok!");
        }
    );
}

rp(options)
    .then(getObj)
    .then(writeObj)
    .catch((err)=>{
        console.log('error',err);
        console.log(cookie_session.session);
    });
