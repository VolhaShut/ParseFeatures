const rp=require('request-promise'); //import
const fs=require('fs');
const options = {
    uri: 'https://jira.wolterskluwer.io/jira/rest/api/2/search?jql=project%20%3D%20CU%20AND%20type%20%3D%20Test%20AND%20labels%20%3D%20Automated',
    qs: {
        postId:'1',     
    },
    headers: {
        'Authorization': 'Basic eWFuLnNhZG92c2t5OkNuZWtteGJyMTE='
    },
    json: true // Automatically parses the JSON string in the response 
};

function getObj(repos) {
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
    })
