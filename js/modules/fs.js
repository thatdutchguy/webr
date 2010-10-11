var binding = process.binding("fs")

exports = {
  readFile: binding.readFile
}