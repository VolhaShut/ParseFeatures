var lo = require('lodash');

function Background(json) {
    this.json = json;
}

Background.prototype.toString = function() {
    return new Scenario(this.json).toString();
};

function DataTable(json) {
    this.json = json;
}


DataTable.prototype.toString = function() {
    var out = [];

    for (var i = 0; i < this.json.rows.length; i++) {
        var row = [''];
        for (var j = 0; j < this.json.rows[i].cells.length; j++) {
            row.push(this.json.rows[i].cells[j].value);
        }
        row.push('');
        out.push(row.join('|'));
    }
    var str = out.join('\n');
    return str;
};


function Tag(json) {
    this.json = json;
}

Tag.prototype.toString = function() {
    return this.json.name.toString();
};


function Step(json) {
    this.json = json;
}
Step.prototype.toString = function() {

    var returnStr = '';
    returnStr += this.json.keyword.toString() + this.json.text;

    if (this.json.argument) {
        var argumentStr = Factory(this.json.argument.type, this.json.argument).toString();
        returnStr += "\n" + argumentStr;
    }
    return returnStr;
};

function Example(json) {
    this.json = json;
}
Example.prototype.toString = function() {
    var example = this.json;
    var header = lo.map(example.tableHeader.cells, "value");
    var rows = lo.map(example.tableBody, function(row) {
        return lo.map(row.cells, "value");
    });
    var outList = lo.map([].concat([header], rows), function(row) {
        return "|" + row.join("|") + "|";
    });
    return "Examples:\n" + outList.join("\n");
};



function ScenarioOutline(json) {
    this.json = json;
}


ScenarioOutline.prototype.toString = function() {

    var scenario = new Scenario(this.json);
    var examples = lo.map(this.json.examples, function(example) {
        return new Example(example);
    });
    return scenario.toString() + "\n" + examples.join("\n");
};

function Scenario(json) {
    this.json = json;
}

Scenario.prototype.toString = function() {
    var tags = lo.map(this.json.tags, function(json) {
        return (new Tag(json)).toString();
    });
    var steps = lo.map(this.json.steps, function(json) {
        return (new Step(json)).toString();
    });

    var returnStr = '';


    if (!lo.isEmpty(tags)) {
        returnStr += tags.join('\n');
        returnStr += "\n";
    }

    returnStr += this.json.keyword + ': ';

    if (this.json.name) {
        returnStr += this.json.name;
    }
    returnStr += "\n";

    if (!lo.isEmpty(steps)) {
        returnStr += steps.join('\n');
        returnStr += "\n";
    }

    return returnStr;
};

function DocString(json) {
    this.json = json;
}

DocString.prototype.toString = function() {
    var contents = this.json.content.toString();
    // TODO: what if contents contain """ ?!
    return '"""\n' + contents + '\n"""';
};

function Factory(type, json) {
    switch (type) {
        case "Scenario":
            return new Scenario(json);
        case "ScenarioOutline":
            return new ScenarioOutline(json);
        case "DataTable":
            return new DataTable(json);
        case "Tag":
            return new Tag(json);
        case "Feature":
            return new Feature(json);
        case "Step":
            return new Step(json);
        case "Example":
            return new Example(json);
        case "Background":
            return new Background(json);
        case "DocString":
            return new DocString(json);
    }
}

function Feature(json) {
    this.json = json;
}

Feature.prototype.toString = function() {
    var returnStr = '';

    var tags = [];
    if (this.json.tags) {
        tags = lo.map(this.json.tags, function(json) {
            return Factory(json.type, json).toString();
        });
    }

    var description = this.json.description || '';

    var background = '';
    if (this.json.background) {
        background = Factory(this.json.background.type, this.json.background).toString();
    }


    var scenarios = [];
    if (this.json.scenarioDefinitions) {
        scenarios = lo.map(this.json.scenarioDefinitions, function(json) {
            return Factory(json.type, json).toString();
        });
    }

    if (!lo.isEmpty(tags)) {
        returnStr += tags.join('\n');
        returnStr += "\n";
    }

    returnStr += this.json.keyword.toString() + ": " + this.json.name.toString();

    if (description) {
        returnStr += "\n" + description;
    }

    if (background) {
        returnStr += "\n\n" + background + "\n";
    }

    returnStr += "\n" + scenarios.join('\n\n');
    returnStr += "\n";
    return returnStr;

};


function formatter(json) {
    var feature = new Feature(json);
    return feature.toString();
}

module.exports = {
    Feature: Feature,
    Tag: Tag,
    Scenario: Scenario,
    formatter: formatter,
    ScenarioOutline: ScenarioOutline,
    Step: Step,
    DataTable: DataTable,
    Example: Example,
    Background: Background,
};
