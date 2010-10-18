// jasmine.getEnv().addReporter(new jasmine.WebrReporter())
jasmine.isSuite = function(suite) {
  return suite instanceof jasmine.Suite
}
jasmine.isSpec = function(spec) {
  return spec instanceof jasmine.Spec
}

jasmine.getEnv().addReporter(new WebrReporter(jasmine))
jasmine.getEnv().execute()
