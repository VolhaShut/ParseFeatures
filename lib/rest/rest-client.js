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
    }
    else {
        throw "Login failed :(";
    }
});
