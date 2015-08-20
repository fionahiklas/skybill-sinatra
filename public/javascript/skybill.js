/**
 * Needed to load the templates and parse them
 */
$(document).ready(function () {
    console.log("Loading template sources");
    var topLevelTemplateSource = $('#topLevelTemplateHtml').html();
    console.log("Creating compiled sources");
    window.topLevelTemplate = Handlebars.compile(topLevelTemplateSource);
});


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
function require_template(templateName) {
    var template = $('#template_' + templateName);
    if (template.length === 0) {
        var tmpl_dir = './templates';
        var tmpl_url = tmpl_dir + '/' + templateName + '.tmpl';
        var tmpl_string = '';

        $.ajax({
            url: tmpl_url,
            method: 'GET',
            async: false,
            contentType: 'text',
            success: function (data) {
                tmpl_string = data;
            }
        });

        $('head').append('<script id="template_' +
        templateName + '" type="text/template">' + tmpl_string + '<\/script>');
    }
}
