var Valid = require('./featureSchema').Feature;

module.exports = function(featureJSON) {
    return {
        valid: Valid(featureJSON),
        errors: Valid.errors(featureJSON)
    };
};
