var schema = require("js-schema");

var Tag = schema({
    "type": "Tag",
    "name": /^@.*/
});

var Comment = schema({
    "type": "Comment",
    "text": /^\s*#.*/
});


var Step = schema({
    "keyword": ["Given ", "And ", "When ", "Then ", "But "],
    "location": undefined,
    "text": String,
    "type": "Step"
});


var Example = schema({
    "keyword": "Examples",
    "location": undefined,
    "name": String,
    "tags": Array.of(Tag),
    "type": "Examples"
});

var Scenario = schema({
    "keyword": "Scenario",
    "name": String,
    "steps": Array.of(Step),
    "tags": Array.of(Tag),
    "type": "Scenario"
});

var ScenarioOutline = schema({
    "examples": Array.of(Example),
    "keyword": "Scenario Outline",
    "name": String,
    "steps": Array.of(Step),
    "tags": Array.of(Tag),
    "type": "ScenarioOutline"
});

var Background = schema({
    "?comments": Array.of(Comment),
    "description": [null, String],
    "keyword": "Feature",
    "language": String,
    "name": String,
    "scenarioDefinitions": Array.of([Scenario, ScenarioOutline]),
    "tags": Array.of(Tag),
    "type": "Feature"
});

var Feature = schema({
    "?comments": Array.of(Comment),
    "?description": [null, String],
    "keyword": "Feature",
    "language": String,
    "name": String,
    "scenarioDefinitions": Array.of([Scenario, ScenarioOutline]),
    "tags": Array.of(Tag),
    "type": "Feature"
});

module.exports = {
    Tag: Tag,
    Comment: Comment,
    Step: Step,
    Example: Example,
    Scenario: Scenario,
    ScenarioOutline: ScenarioOutline,
    Feature: Feature
};
