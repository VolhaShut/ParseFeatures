const fs=require('fs');
const readline = require('readline');

function reader(fileList) {
    //let scenarioList=[];
    //let scenario;
    let features={
        "feature":[]
    };
    let feature={
        "title":"",
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

            rl.on('line',  (line) => {
                if (line.match(/^Feature:/g)){
                        //features.feature.push({feature.title=});
                        feature.title=line.replace(/^Feature:/ig,'');
                }
                if (line.match(/^\s+?@/g)){
                        if (testChecker===false) {
                            testChecker=true;
                            feature.tests.push(test);
                            makeTestEmpty();
                            test.tags.push(line);
                        }else {
                            test.tags.push(line);
                        }
                }
                if (line.match(/^\s+?Scenario/g)){
                    testChecker=false;
                    if (line.match(/^\s+?Scenario Outline:/g)){
                        test.title=line.replace(/^\s+?Scenario Outline:/ig,'');
                        test.type='outline';
                    }
                    test.title=line.replace(/^\s+?Scenario:/ig,'');
                        test.type='single';
                    
                }
                if (line.match(/^\s+?And|When|Given|Then/g)){
                    steps.push(line);
                }
                
            });
            rl.on('close', ()=>{
                //console.log(feature);
                features.feature.push(feature);
                feature={
                    "title":"",
                    "tests": []
                };
            })
            //console.log(fs.readFileSync(file,'utf8'));
        }
    })

    

    function makeTestEmpty(){
    tags=[];
    steps=[];
    examples=[];
    test={
        "tags": tags,
        "title": "",
        "type":"",
        "scenarioCount":"",
        "countOfCharacters":"",
        "steps":steps,
        "examples":examples
    }
}
 
}



exports.reader = reader;
