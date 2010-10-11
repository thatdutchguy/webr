(function(global, root) {
  var list = global.window.document.getElementsByTagName("script")
  var sys = require("sys")
  for (var i = 0; i < list.length; i++) {
    var item = list.item(i),
        src = item.getAttribute('src')
    if (src.length == 0) {
      item.text = item.innerHTML  // assign to trigger eval
    } else {
      if (!src.match(/^(http|https)\:\/\//)) {
        src = 'file://' + root + '/' + src
      }
      item.src = src  // assign it to trigger load
    }
  }
  
  if (window.onload) {
    window.onload()
  }  
})
