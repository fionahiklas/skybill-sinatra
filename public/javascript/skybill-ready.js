/*
    This file should be included AFTER the Skybill.js particularly for testing.

    If testing and the relative template location is different then override the
    templatePath() function in skybill.js before including this file
 */

/**
 * Require all the templates
 *
 * Since we're not using AMD (Asynchronous Module Definition) and Require.js we're
 * using the require_template method in skybill.js
 */
function require_all_templates() {
    var template_base = templatePath();
    console.log('Requiring templates from: ' + template_base);

    require_template('topLevel', template_base);
    require_template('package', template_base);
    require_template('skyStore', template_base);
    require_template('callCharges', template_base);
}

/**
 * Compile all the templates we need
 *
 * Save the compiled version on the window so we can go and grab them later
 */
function compile_all_templates() {
    console.log('Compiling templates');

    window.topLevelCompiledTemplate = compileTemplate('topLevel');
    window.packagesCompiledTemplate = compileTemplate('package');
    window.skyStoreCompiledTemplate = compileTemplate('skyStore');
    window.callChargesCompiledTemplate = compileTemplate('callCharges');
}


/**
 * Needed to load the templates and parse them
 */
$(document).ready(function () {
    console.log('Skybill ready function called');
    var skybillTargetNode = $('#skybill');

    if(skybillTargetNode) {
        console.log('Found a target node to load the bill into');

        require_all_templates();
        compile_all_templates();

        console.log('About to go and get all of the data and render the templates');
        getbillJson();
    } else {
        console.log('Didn\'t find the target div element, skipping');
    }
});