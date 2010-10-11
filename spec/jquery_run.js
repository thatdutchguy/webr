var sys    = require("sys"),
    jsdom  = require("jsdom"),
    window = jsdom.jsdom().createWindow();

var navigator = window.navigator
var location = window.location

jsdom.jQueryify(window, "./ext/jquery/jquery-1.4.2.js", function() {
  window.jQuery('body').append("<div class='testing'>Hello World, It works!</div>");
  callback(window.jQuery(".testing").text())
});
