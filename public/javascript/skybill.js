/**
 * Convert a template ID into the name of the script node to hold it
 *
 * @param templateID
 */
function templateScriptName(templateID) {
    return 'template_' + templateID;
}

function templateScriptSearchID(templateID) {
    return '#' + templateScriptName(templateID);
}

/**
 * Find the template source and compile
 *
 * @param templateID
 * @returns {*}
 */
function compileTemplate(templateID) {
    var templateHtml = $(templateScriptSearchID(templateID)).html();
    var result = undefined;

    if (templateHtml && templateHtml.length > 1) {
        console.log('There is some HTML template to compile');
        result = Handlebars.compile(templateHtml);
    } else {
        console.log('Couldn\'t find any HTML, skipping this template');
    }
    return result;
}

/**
 * Render a template to a given node
 *
 * @param templateToRender
 * @param jsonData
 * @param destinationDiv
 */
function renderTemplate(templateToRender, jsonData, destinationDiv) {

    var resultHtml = templateToRender(jsonData);
    console.log('Rendered to: ' + resultHtml);
    console.log('Sending to #' + destinationDiv);
    $('#'+destinationDiv).html(resultHtml);
}

/**
 * Copied from a solution on stackoverflow: http://stackoverflow.com/questions/8366733/external-template-in-underscore
 *
 * Allows loading of templates from seperate files.
 *
 * @param templateName
 */
function require_template(templateID, templatePath) {

    console.log('Loading template: ' + templateID + ' from path: ' + templatePath);

    var template = $(templateScriptSearchID(templateID));
    if (template.length === 0) {
        console.log('Couldn\'t find template, loading for: ' + templateID);
        var tmpl_url = templatePath + '/' + templateID + '.html';
        var tmpl_string = '';

        console.log('Loading data from: ' + tmpl_url);
        $.ajax({
            url: tmpl_url,
            method: 'GET',
            async: false,
            dataType: 'text',
            success: function (data) {
                console.log('Loaded data for template: ' + tmpl_url);
                tmpl_string = data;
            }
        });

        console.log('Loaded this template data: ' + tmpl_string + 'length: ' + tmpl_string.length);
        $('head').append('<script id="' + templateScriptName(templateID) + '" type="text/x-handlebars-template">' + tmpl_string + '<\/script>');
    }
}

/**
 * This function is purely for testing purposes as it allows the base path
 * for the templates to be overridden when we are running QUnit tests.
 *
 * @returns {string}
 */
function templatePath() {
    return '/javascript/templates';
}

/**
 * This function is purely for testing purposes as it allows the URL to be
 * changed.
 *
 * @returns {string}
 */
function getbillUrl() {
    return '/getbill';
}

/**
 * Render all of the templates
 *
 * @param jsonData
 */
function renderAllTemplates(jsonData) {
    console.log('Rendering all templates ...');
    renderTemplate(window.topLevelCompiledTemplate, jsonData, 'billArea');
    renderTemplate(window.packagesCompiledTemplate, jsonData.package, 'package');
    renderTemplate(window.skyStoreCompiledTemplate, jsonData.skyStore, 'skyStore');
    renderTemplate(window.callChargesCompiledTemplate, jsonData.callCharges, 'callCharges');
    console.log('Should all have been rendered!');
}

/**
 * Retrieve the bill data from the server
 */
function getbillJson() {
    $.getJSON(getbillUrl(), "", function(jsonData) {
        console.log('Got skybill, rendering ...');
        renderAllTemplates(jsonData);
    });
}