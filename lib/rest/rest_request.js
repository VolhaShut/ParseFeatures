const rp = require('request-promise'); //import
const fs = require('fs');
const cookie_session = require('./../sessionName.json');
const path = require('path');

function getJiraTickets(start) {
    let startAt = start;
    const options = {
        method: 'POST',
        uri: 'https://jira.wolterskluwer.io/jira/rest/api/2/search',
        body: {
            "jql": "project = 11652 and issuetype = Test AND labels = Automated",
            "startAt": startAt
        },
        headers: {
            // Set the cookie from the session information
            cookie: cookie_session.session,
            "Content-Type": "application/json"
        },
        json: true // Automatically parses the JSON string in the response
    };

    function getObj(repos) {
        let response = [];
        //response.push({"startAt": startAt, "totalTests": repos.total});
        repos.issues.map((issue) => {
            response.push({
                "link": issue.self,
                "key": issue.key,
                "labels": issue.fields.labels,
                "title": issue.fields.summary
            })
        });
        return {"response":response,"totalTests":repos.total};
    }

    return rp(options)
        .then(getObj)
        .catch((err) => {
            console.log('error', err);
            console.log(cookie_session.session);
        });
}
exports.getJiraTickets = getJiraTickets;

