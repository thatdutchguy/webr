(function() {

  var $template = function(template, replacements) {
    var r, rex
    for (r in replacements) {
      template = template.replace(new RegExp('\{\{' + r + '\}\}', 'g'), replacements[r])
    }
    return template;
  }
  var $plural = function(count, word) {
    return [count, word + (count == 1 ? '' : 's')].join(" ")
  }  
  var sys = require('sys')

  jasmine.WebrReporter = function() {
    this.started = false;
    this.finished = false;
    this.failedSpecs = []
  };

  jasmine.WebrReporter.prototype.reportRunnerStarting = function(runner) {
    this.started = true;
    this.startedAt = (new Date).getTime()
    sys.puts("Running Jasmine Code Examples")
   };

  jasmine.WebrReporter.prototype.reportRunnerResults = function(runner) {
    this.finished = true;

    var results = runner.results(),
        specs = runner.specs(),
        duration = ((new Date).getTime() - this.startedAt) / 1000

    sys.puts('')
    this.failedSpecs.forEach(function(spec, idx) {
      //   messages: spec.results().getItems(),
      //   result: spec.results().failedCount > 0 ? "failed" : "passed"
      var results = spec.results(),
          messages = results.getItems()
      
      sys.puts('')
      sys.puts("=[ " + idx + " ]========================================")
      sys.puts(spec.getFullName())
      messages.forEach(function(message) {
        sys.puts(message.toString())
        if (message.trace.stack) {
          sys.puts('')
          sys.puts(message.trace.stack)
        }
      })
    })

    sys.puts('')
    sys.puts($template(
      "{{examples}}, {{failures}}", {
        examples: $plural(specs.length, "example"),
        failures: $plural(results.failedCount, "failure")
    }))
    
    sys.puts($template(
      "Finished in {{duration}} seconds", {
        duration: duration
      }
    ))

  };

  jasmine.WebrReporter.prototype.reportSuiteResults = function(suite) {
    //   result: suite.results().failedCount > 0 ? "failed" : "passed"
  };

  jasmine.WebrReporter.prototype.reportSpecResults = function(spec) {
    var results = spec.results(),
        status = results.failedCount > 0 ? 'failed' : 'passed'
    if (status == "failed") {
      process.stdout.write('F')
      this.failedSpecs.push(spec)
    } else {
      process.stdout.write('.')
    }
  };

  jasmine.WebrReporter.prototype.log = function(str) {
  };

})()
