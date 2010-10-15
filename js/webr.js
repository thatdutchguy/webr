(function() {
  var paths = process.webr.require_paths
  for (var i = 0, len = paths.length; i < len; i++) {
    require.paths.push(paths[i])
  }

  function alert(msg) {
    require('sys').puts("[ALERT]: " + msg)
  }

  function updateGlobal() {
    for (var prop in window) {
      if (!(prop in global) && prop != 'self') {
        global[prop] = window[prop]
      }
    }
  }

  function script(path) {
    var fs = require('fs'),
        sys = require('sys')
        data = fs.readFileSync(path),
        Script = process.binding('evals').Script
    Script.runInThisContext(data, path)
    updateGlobal()
  }

  global.require = require
  global.script = script
  window = global.window = require('jsdom').jsdom(process.webr.html).createWindow()
  window.alert = alert
  window.document.location = window.location

  if ('search' in window.location) {
    // nothing
  } else {
    window.location.search = ""
  }

  updateGlobal()

  var scripts = process.webr.scripts
  for (var i = 0, len = scripts.length; i < len; i++) {
    script(scripts[i])
  }
  
  if (process.webr.options.outputDocument) {
    process.addListener('exit', function () {
      require('sys').puts(window.document.innerHTML)
    })
  }

})()

// var list = global.window.document.getElementsByTagName("script")
// var sys = require("sys")
// for (var i = 0; i < list.length; i++) {
//   var item = list.item(i),
//       src = item.getAttribute('src')
//   if (src.length == 0) {
//     item.text = item.innerHTML  // assign to trigger eval
//   } else {
//     if (!src.match(/^(http|https)\:\/\//)) {
//       src = 'file://' + root + '/' + src
//     }
//     item.src = src  // assign it to trigger load
//   }
// }
// 
// if (window.onload) {
//   window.onload()
// }  
