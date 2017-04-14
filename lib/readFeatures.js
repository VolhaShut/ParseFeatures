const fs = require('fs');
const readline = require('readline');

function reader(fileList) {
    return new Promise(function (resolve) {
        let pr = [];
        fileList.forEach(file => {
            pr.push(new Promise(function (resolve) {
                if (file.match(/.feature$/g)) {
                    return readFileByLine(file)
                        .then((feature) => {
                            resolve(feature);
                        })
                }
            }))
        });
        Promise.all(pr).then((features) => {
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
    let test = {};
    let tests = [];
    let tempScenarioTitle;
    return new Promise(function (resolve) {
        let rl = readline.createInterface({
            input: fs.createReadStream(file)
        });

        rl.on('line', (line) => {

            if (line.match(/^Feature:/g)) {
                console.log(file);
                title = line.replace(/^Feature:/ig, '');
                tempScenarioTitle = '';
            }
            if (line.match(/^\s+?@/g)) {
                if (testChecker === false) {
                    testChecker = true;
                    if (Object.keys(test).length != 0) {
                        tests.push(test);
                    }
                    makeTestEmpty();
                    test.tags.push(line);
                    test.countOfCharacters = line.length;
                } else {
                    test.tags.push(line);
                    test.countOfCharacters += line.length;
                }
            }
            if (line.match(/^\s+?Scenario/g)) {
                testChecker = false;
                test.countOfCharacters += line.length;
                if (tempScenarioTitle.length != 0) {
                    if (tempScenarioTitle === line) {
                        test.scenarioCount += 1;
                    } else {
                        tempScenarioTitle = line;
                    }
                } else {
                    tempScenarioTitle = line;
                }
                if (line.match(/^\s+?Scenario Outline:/ig)) {
                    test.title = line.replace(/^\s+?Scenario Outline:/ig, '');
                    test.type = 'outline';
                } else {
                    test.title = line.replace(/^\s+?Scenario:/ig, '');
                    test.type = 'single';
                }
            }
            if (line.match(/^\s+?And|When|Given|Then/g)) {
                test.countOfCharacters += line.length;
                steps.push(line);
            }
            if (line.match(/^\s+?\|/g)) {
                test.countOfCharacters += line.length;
                examples.push(line);
            }
        });
        rl.on('error', (err) => {
            console.log(err);
        });
        rl.on('close', () => {
            tests.push(test);
            resolve({"feature_title": title, "tests": tests});
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
            "scenarioCount": "1",
            "countOfCharacters": "",
            "steps": steps,
            "examples": examples
        }
    }
}


exports.reader = reader;
