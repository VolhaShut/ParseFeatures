const fs=require('fs');
const path=require('path');

function finder(dirname) {
    let fileList = [];

    function dirTravel(dirname) {
        if (fs.existsSync(dirname)) {
            dirname = fs.realpathSync(dirname);
            fs.readdirSync(dirname).forEach(file => {
                file = path.normalize(dirname + '/' + file);
                if (fs.statSync(file).isDirectory()) {
                    dirTravel(file);
                } else {
                    fileList.push(file);
                }
            });
        }else {
            console.log('Folder '+dirname+' does not exist');
        }
    }
    dirTravel(dirname);
    return fileList;
}
exports.finder = finder;
