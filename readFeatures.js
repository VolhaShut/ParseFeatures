const fs=require('fs');
const readline = require('readline');

function reader(fileList) {
    let scenarioList=[];
    let scenario;
    let features={
        "feature":[]
    };
    let feature={
        "tests": []
    };
    let tempStr;
    let testChecker=false;
    let tags=[];
    let steps=[];
    let examples=[];
    let test={
        "tags": tags,
        "title": "",
        "type":"",
        "scenarioCount":"",
        "countOfCharacters":"",
        "steps":steps,
        "examples":examples
    }

    fileList.forEach(file=>{
        if (file.match(/.feature$/g)){
            let rl = readline.createInterface({
                input: fs.createReadStream(file)
               });

            rl.on('line', function (line) {
                if (line.match(/Feature:/g)){
                        tempStr=line;
                        features.feature={feature_name:tempStr.replace(/Feature:/ig,'')};
                }
                if (line.match(/@/g)){
                        if (test===false) {
                            test=true;
                            features.feature.test.tags=tags.push(line);
                        }else {

                        }
                }
                          console.log('Line from file:', line);
            });
            //console.log(fs.readFileSync(file,'utf8'));
        }
    });
    console.log('Done!');
}

exports.reader = reader;
