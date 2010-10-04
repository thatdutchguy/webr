(function(global, cache, resolve, resolvePath, basename) {
  
  function createRequire(path) {
    var require = function(namespace) {
      var ns = namespace.split('/').pop()
      if (ns in cache) return cache[ns]
      
      var p = []
      for (var i = 0; i < path.length; i++) {
        p.push(path[i])
      }
      if (namespace.match(/^\./)) {
        p.push(resolvePath(namespace, p))
      }

      var source = resolve(namespace, path)
      return (cache[ns] = Function("exports", "require", source + ";return exports").call(global, {}, createRequire(p)))
    }
    return require
  }
  
  return createRequire([])
})
