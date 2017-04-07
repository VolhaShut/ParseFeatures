'use strict';

var fs = require('fs');
var path = require('path');
var lo = require('lodash');
var mkdirp = require('mkdirp');

var formatter = require('./lib/formatter').formatter;
var parse = require('./lib/utils').parse;

var outputCalculator = function(filepath, parsedDirName, reasonableDir) {
    // Assumption: reasonableDir is part of filepath
    var relative = path.normalize(filepath).split(reasonableDir)[1];
    return path.join(reasonableDir, parsedDirName, relative);
};

/**
 * Return last reasonable dir -> as follows
 * Assumption: string "/**" exists in pathToFile
 * @param {string} pathToFile - /home/user/$CHEETAH_HOME/e2e/cucumber/features/** /*.feature
 * @returns {string} lastReasonableDir - /home/user/$CHEETAH_HOME/e2e/cucumber/features
 */
var lastReasonableDir = function(pathToFile) {
    var reasonable = pathToFile.split(path.sep + "**");
    if (reasonable[1]) {
        reasonable = reasonable[0];
    } else {
        reasonable = path.dirname(pathToFile);
    }
    return reasonable;
};

var produceAstList = function(inputFilesStruct, parsedDirName) {
    return lo.flatMap(inputFilesStruct, function(fileStruct) {
        var reasonableDir = lastReasonableDir(fileStruct.spec);

        var singleSpecASTList = lo.map(fileStruct.files, function(file) {

            var outputPath = outputCalculator(file, parsedDirName, reasonableDir);
            var featureText = fs.readFileSync(file, 'UTF-8');
            try {
                var ast = parse(featureText);
                // Add metadata with filePaths to write later
                ast.inputPath = file;
                ast.outputPath = outputPath;
                return ast;
            } catch (e) {
                console.error(e.message);
                throw e;
            }
        });

        return singleSpecASTList;
    });

};

var requireMappers = function(mappersStr) {
    return lo.map(mappersStr, function(str) {
        var tempMapper = require('./lib/mappers')[str];

        if (tempMapper) {
            return tempMapper;
        } else {
            throw Error("ERROR: There is no module named " + str);
        }
    });
};


module.exports = function(inputFilesStruct, mappersStr, parsedDirName) {


    inputFilesStruct.forEach(function(fileStruct) {
        console.log("From spec:", fileStruct.spec, "Feature files found:", fileStruct.files.length);
    });

    var mappers = requireMappers(mappersStr);
    var inputFeatureAsts = produceAstList(inputFilesStruct, parsedDirName);

    var pipe = lo.flow(mappers);
    var outputFeatureAsts = pipe(inputFeatureAsts);


    outputFeatureAsts.forEach(function(featureAst) {
        var outputPath = path.dirname(featureAst.outputPath);

        // if directory does not exist create it recursively
        // similarly to mkdir -p will create whole dir tree
        try {
            mkdirp.sync(outputPath);
        } catch (err) {
            console.error("Couldn't create directory: ", outputPath);
            throw err;
        }

        var featureText = formatter(featureAst);

        try {
            fs.writeFileSync(featureAst.outputPath, featureText);
            console.log("Wrote featureText: ", featureAst.outputPath);
        } catch (err) {
            console.warn("Couldn't write to file: ", featureAst.outputPath);
            console.warn("Skipping...");
        }
    });
};
