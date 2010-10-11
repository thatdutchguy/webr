(function(global, html) {
  var jsdom = require("jsdom").jsdom
  var sys = require('sys')
  var window = global.window = jsdom(html).createWindow()
  window.document.location = window.location
  if ('search' in window.location) {
    // nothing
  } else {
    window.location.search = ""
  }
  
  window.alert = function(msg) {
    sys.puts(msg)
  }
  
  // make 'global' the window
  for (var prop in window) {
    if (!(prop in global) && prop != 'self') {
      global[prop] = window[prop]
    }
  }  
})
