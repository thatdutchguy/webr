// need this in the ruby class as I can't identify them there
jasmine.isSuite = function(suite) {
  return suite instanceof jasmine.Suite
}
jasmine.isSpec = function(spec) {
  return spec instanceof jasmine.Spec
}

jasmine.getEnv().addReporter(new WebrReporter(jasmine))
jasmine.getEnv().execute()
