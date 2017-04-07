'use strict';

var Gherkin = require('gherkin');

function replaceAll(string, replacements) {
    for (var replacement of replacements) {
        string = string.split("<" + replacement[0] + ">").join(replacement[1]);
    }
    return string;
}

function parse(featureStr) {
    var parser = new Gherkin.Parser(new Gherkin.AstBuilder());
    parser.stopAtFirstError = false;

    var matcher = new Gherkin.TokenMatcher();
    var scanner = new Gherkin.TokenScanner(featureStr);

    return parser.parse(scanner, matcher);
}

module.exports = {
    replaceAll: replaceAll,
    parse: parse
};