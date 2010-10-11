exports = {
  puts: function() {
    process.stdout.writeln([].slice.call(arguments, 0).join(' '))
  },
  log: function(message, label) {
    var str = label ? "[" + label +  "]: " + message : message
    process.stdout.writeln(str)
  }
}