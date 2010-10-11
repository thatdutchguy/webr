var binding = process.binding("fs")

exports = {
  readFile: function(fileName, callback) {
    binding.readFile(fileName, callback)
  }
}