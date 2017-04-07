const rp=require('request-promise'); //import
const fs=require('fs');
const cookie_session=require('./credentials.json');
const options = {
    method: 'POST',
    uri: 'https://jira.wolterskluwer.io/jira/rest/api/2/search?jql=project%20%3D%20CU%20AND%20type%20%3D%20Test%20AND%20labels%20%3D%20Automated',
    body: {
        postId:'1',     
    },
    headers: {
        // Set the cookie from the session information
        cookie: cookie_session.session,
        "Content-Type": "application/json"
    },
    // headers: {
    //     'Authorization': 'Basic eWFuLnNhZG92c2t5OkNuZWtteGJyMTE='
    // },
    json: true // Automatically parses the JSON string in the response 
};

function getObj(repos) {
    console.log(cookie_session.session);
    console.log(repos);
    return repos;
}

function writeObj(repos){
    fs.writeFile(
        'response.json',
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
