const rp=require('request-promise'); //import
const fs=require('fs');
const cookie_session=require('./../sessionName.json');
const options = {
    method: 'DELETE',
    uri: 'https://jira.wolterskluwer.io/jira/rest/auth/1/session',
    headers: {
        // Set the cookie from the session information
        cookie: cookie_session.session,
        "Content-Type": "application/json"
    },
    resolveWithFullResponse: true   // Automatically parses the JSON string in the response
};

rp(options)
    .then((response)=> {
        console.log("DELETE succeeded with status %d", response.statusCode);
        fs.unlink('./lib/credentials.json');
        fs.unlink('./lib/sessionName.json');
    })
    .catch((err)=>{
        console.log('error',err);
        console.log(cookie_session.session);
    });
