const fs=require('fs');
const readline = require('readline');

function reader(fileList) {
    let features=[];
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
    let promises=[];
    let title;
    let tests=[];
    let i=0;
//     fileList=['/home/olga/Projects/ParseFeatures/test/citationSearch.feature',
//   '/home/olga/Projects/ParseFeatures/test/content.feature'];
    console.log(fileList);
    let rl=[];
    
    fileList.forEach(file=>{
        
        if (file.match(/.feature$/g)){
        promises.push(new Promise (function (resolve){
            rl[i] = readline.createInterface({
                input: fs.createReadStream(file)
               });

            rl[i].on('line',  (line) => {
                if (line.match(/^Feature:/g)){
                        console.log(file);                  
                        title=line.replace(/^Feature:/ig,'');
                        features[i]={"title":title, "tests":tests}; 
                        //i++;
                        console.log(title);
                        
                }
                if (line.match(/^\s+?@/g)){
                        if (testChecker===false) {
                            testChecker=true;
                            tests.push(test);
                            makeTestEmpty();
                            test.tags.push(line);
                        }else {
                            test.tags.push(line);
                        }
                }
                if (line.match(/^\s+?Scenario/g)){
                    testChecker=false;
                    if (line.match(/^\s+?Scenario Outline:/ig)){
                        test.title=line.replace(/^\s+?Scenario Outline:/ig,'');
                        test.type='outline';
                    } else {
                    test.title=line.replace(/^\s+?Scenario:/ig,'');
                        test.type='single';
                    }
                    
                }
                if (line.match(/^\s+?And|When|Given|Then/g)){
                    steps.push(line);
                }  
            });
            rl[i].on('close', ()=>{
                console.log(i);
                //i++;
                //console.log(features);
                resolve(features[i]);
            })
            })) 
        }
        
     i++; 
     
     
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
    //console.log(features);
 return Promise.all(promises);
}



exports.reader = reader;
