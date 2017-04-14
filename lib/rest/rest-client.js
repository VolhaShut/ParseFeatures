var Client = require('node-rest-client').Client;
const fs=require('fs');
const path=require('path');
const username=require('./../credentials.json').username;
const password=require('./../credentials.json').password;

client = new Client();
// Provide user credentials, which will be used to log in to JIRA.
var loginArgs = {
    data: {
        "username": username,
        "password": password
    },
    headers: {
        "Content-Type": "application/json"
    }
};
client.post("https://jira.wolterskluwer.io/jira/rest/auth/1/session", loginArgs, function(data, response){
    if (response.statusCode == 200) {
        console.log('succesfully logged in, session:', data.session);
        var session = data.session;
        let cookie= session.name + '=' + session.value;
        let json=JSON.stringify({"session":cookie});
        fs.writeFileSync(path.normalize('./lib/sessionName.json'), json, 'utf8');
        // Get the session information and store it in a cookie in the header
        // var searchArgs = {
        //     headers: {
        //         // Set the cookie from the session information
        //         cookie: session.name + '=' + session.value,
        //         "Content-Type": "application/json"
        //     },
        //     data: {
        //         // Provide additional data for the JIRA search. You can modify the JQL to search for whatever you want.
        //         jql: "project %3D CU AND type %3D Test AND labels %3D Automated"
        //     }
        // };
        // // Make the request return the search results, passing the header information including the cookie.
        // client.post("https://jira.wolterskluwer.io/jira/rest/api/2/search", searchArgs, function(searchResult, response) {
        //     console.log('status code:', response.statusCode);
        //     console.log('search result:', searchResult);
        // });
    }
    else {
        throw "Login failed :(";
    }
});
