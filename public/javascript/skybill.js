/**
 * Needed to load the templates and parse them
 */
$(document).ready(function () {
    console.log("Loading template sources");
    var topLevelTemplateSource = $('#topLevelTemplateHtml').html();
    console.log("Creating compiled sources");
    window.topLevelTemplate = Handlebars.compile(topLevelTemplateSource);
});