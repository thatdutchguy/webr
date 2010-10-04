exports = {
  puts: function(message) {
    process.stdout.writeln(message)
  },
  log: function(message, label) {
    var str = label ? "[" + label +  "]: " + message : message
    process.stdout.writeln(str)
  }
}