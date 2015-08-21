/**
 * Needed to load the templates and parse them
 */
/*$(document).ready(function () {
    console.log("Loading template sources");
    var topLevelTemplateSource = $('#topLevelTemplateHtml').html();
    console.log("Creating compiled sources");
    window.topLevelTemplate = Handlebars.compile(topLevelTemplateSource);
});*/

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
    return Handlebars.compile(templateHtml);
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
    console.log("Rendered to: " + resultHtml);
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

    var tmpl_dir = templatePath || '/javascript/templates';
    console.log('Loading template: ' + templateID + ' from path: ' + templatePath);

    var template = $(templateScriptSearchID(templateID));
    if (template.length === 0) {
        console.log('Couldn\'t find template, loading for: ' + templateID);
        var tmpl_url = tmpl_dir + '/' + templateID + '.html';
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
