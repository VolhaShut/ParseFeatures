const rp=require('request-promise'); //import
const fs=require('fs');
const cookie_session=require('./credentials.json');
const options = {
    method: 'DELETE',
    uri: 'https://jira.wolterskluwer.io/jira/rest/auth/1/session',
    headers: {
        // Set the cookie from the session information
        cookie: "JSESSIONID=2347FC3D073FD6B457A09044C5BB15C9",
        "Content-Type": "application/json"
    },
    // headers: {
    //     'Authorization': 'Basic eWFuLnNhZG92c2t5OkNuZWtteGJyMTE='
    // },
    resolveWithFullResponse: true   // Automatically parses the JSON string in the response
};

rp(options)
    .then((response)=> {
        console.log("DELETE succeeded with status %d", response.statusCode);
    })
    .catch((err)=>{
        console.log('error',err);
        console.log(cookie_session.session);
    });
