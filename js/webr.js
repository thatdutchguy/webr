;(function() {
  var fs = require('fs')
  var sys = require("sys")
  var Script = process.binding('evals').Script
  var scripts = {}

  // update node paths
  var paths = process.webr.require_paths
  for (var i = 0, len = paths.length; i < len; i++) {
    require.paths.push(paths[i])
  }

  // stick properties added to window in the global object
  // TODO: figure out why I need this instead of doing Script.runInNewContext(data, window, path)
  function copyWindowToGlobal() {
    for (var prop in window) {
      if (!(prop in global) && prop != 'self') {
        global[prop] = window[prop]
      }
    }
  }

  // load a script from a file, relative to the webr 'root' property
  function script(path) {
    var pre = path.match(/^\//) ? '' : process.webr.root + '/'
    var fullPath = fs.realpathSync(pre + path)
    if (fullPath in scripts) {
      // don't load script twice in the same context
      // multiple file loading/reporting messes up otherwise
      // TODO: rethink this
      return
    }
    var data = fs.readFileSync(fullPath)
    scripts[fullPath] = data
    scriptEval(data, fullPath)
  }

  // evaluate a script
  function scriptEval(data, path) {
    path = path || null
    Script.runInThisContext(data, path)
    copyWindowToGlobal()
  }

  // expose require and script to the outside world
  global.require = require
  global.script = script

  // prepare 'browser'
  document = require('jsdom').jsdom(process.webr.html)
  window = document.createWindow()

  document.location = window.location
  if ('search' in window.location) {
    // nothing
  } else {
    window.location.search = ""
  }

  // 'emulate' window load
  window.addEventListener = function(type, listener, capturing) {
    if (type == 'load' || type == "DOMContentLoaded") {
      setTimeout(listener, 0)
    }
  }
  window.__defineSetter__("onload", function(listener) {
    setTimeout(listener, 0)
  })

  // fake XMLHttpRequest so jQuery 1.4.3 loads
  window.XMLHttpRequest = function() {}

  copyWindowToGlobal()

  // run all scripts assigned by Webr
  var scripts = process.webr.scripts
  for (var i = 0, len = scripts.length; i < len; i++) {
    script(scripts[i])
  }

  // run all scripts in the document
  var list = document.getElementsByTagName("script")
  for (var i = 0; i < list.length; i++) {
    var item = list.item(i),
        src = item.getAttribute('src')
    if (src.length == 0) {
      scriptEval(item.textContent)
    } else {
      if (src.match(/^(http|https)\:\/\//)) {
        throw new Error("http support still needs to be implemented")
      } else {
        script(src)
      }
    }
  }

})()
