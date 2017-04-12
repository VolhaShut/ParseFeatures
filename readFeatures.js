const fs = require('fs');
const readline = require('readline');

function reader(fileList) {
    return new Promise(function (resolve) {
        console.log(fileList);
        let pr = [];
        fileList.forEach(file => {
            pr.push(new Promise(function (resolve) {
                if (file.match(/.feature$/g)) {
                    return readFileByLine(file)
                        .then((feature) => {
                            console.log(feature);
                            resolve(feature);
                        })
                }
            }))
        });
        Promise.all(pr).then((features) => {
            console.log(features);
            resolve(features);
        });
    })
}

function readFileByLine(file) {
    let testChecker = false;
    let tags = [];
    let steps = [];
    let examples = [];
    let title;
    let test = {
        // "tags": tags,
        // "title": "",
        // "type": "",
        // "scenarioCount": "",
        // "countOfCharacters": "",
        // "steps": steps,
        // "examples": examples
    };
    let tests = [];
    return new Promise(function (resolve) {
        let rl = readline.createInterface({
            input: fs.createReadStream(file)
        });

        rl.on('line', (line) => {
            if (line.match(/^Feature:/g)) {
                console.log(file);
                title = line.replace(/^Feature:/ig, '');
                //features[i] = {"title": title, "tests": tests};
                //i++;
                //console.log(title);
            }
            if (line.match(/^\s+?@/g)) {
                if (testChecker === false) {
                    testChecker = true;
                    if(Object.keys(test).length != 0){
                        tests.push(test);
                    }

                    makeTestEmpty();
                    test.tags.push(line);
                } else {
                    test.tags.push(line);
                }
            }
            if (line.match(/^\s+?Scenario/g)) {
                testChecker = false;
                if (line.match(/^\s+?Scenario Outline:/ig)) {
                    test.title = line.replace(/^\s+?Scenario Outline:/ig, '');
                    test.type = 'outline';
                } else {
                    test.title = line.replace(/^\s+?Scenario:/ig, '');
                    test.type = 'single';
                }
            }
            if (line.match(/^\s+?And|When|Given|Then/g)) {
                steps.push(line);
            }
        });
        rl.on('error', (err) => {
            console.log(err);
        });
        rl.on('close', () => {
            //console.log(i);
            //i++;
            console.log(title);
            resolve({"title": title, "tests": tests});
        })
    });

    function makeTestEmpty() {
        tags = [];
        steps = [];
        examples = [];
        test = {
            "tags": tags,
            "title": "",
            "type": "",
            "scenarioCount": "",
            "countOfCharacters": "",
            "steps": steps,
            "examples": examples
        }
    }
}


exports.reader = reader;
