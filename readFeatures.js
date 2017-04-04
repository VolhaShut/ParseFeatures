const fs=require('fs');
const readline = require('readline');

function reader(fileList) {
    let scenarioList=[];
    let scenatio;
    fileList.forEach(file=>{
        if (file.match(/.feature$/g)){
            let rl = readline.createInterface({
                input: fs.createReadStream(file)
               });

            rl.on('line', function (line) {
                if (line.match(/@jira/g)){
                        
                }
                          console.log('Line from file:', line);
            });
            //console.log(fs.readFileSync(file,'utf8'));
        }
    });
    console.log('Done!');
}

exports.reader = reader;
