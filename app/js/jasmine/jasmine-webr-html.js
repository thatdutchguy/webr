;(function() {

  var $id = function(id) {
    return document.getElementById(id)
  }
  var $listToArray = function(list) {
    var a = []
    for (var i = 0, len = list.length; i < len; i++) {
      a.push(list.item(i))
    }
    return a
  }
  var $tag = function(tagName) {
    return $listToArray(document.getElementsByTagName(tagName))
  }
  var $class = function(className) {
    return $listToArray(document.getElementsByClassName(className))
  }
  var $append = function(id, html) {
    $id(id).innerHTML += html
  }
  var $template = function(template, replacements) {
    var r, rex
    for (r in replacements) {
      template = template.replace(new RegExp('\{\{' + r + '\}\}', 'g'), replacements[r])
    }
    return template;
  }
  var $safe = function(s) {
    return s.replace(/</g, '&lt;').replace(/>/g, '&gt;')
  }
  var $plural = function(count, word) {
    return [count, word + (count == 1 ? '' : 's')].join(" ")
  }  
  var $remove = function(id) {
    var el = document.getElementById(id)
    el.parentNode.removeChild(el)
  }

  jasmine.WebrReporter = function() {
    this.started = false;
    this.finished = false;
    this.suites_ = [];
    this.results_ = {};
  };

  jasmine.WebrReporter.prototype.reportRunnerStarting = function(runner) {
    this.started = true;
    this.startedAt = (new Date).getTime()
   };

  jasmine.WebrReporter.prototype.suites = function() {
    return this.suites_;
  };

  jasmine.WebrReporter.prototype.summarize_ = function(suiteOrSpec) {
    var isSuite = suiteOrSpec instanceof jasmine.Suite;
    var summary = {
      id: suiteOrSpec.id,
      name: suiteOrSpec.description,
      type: isSuite ? 'suite' : 'spec',
      children: []
    };

    if (isSuite) {
      var children = suiteOrSpec.children();
      for (var i = 0; i < children.length; i++) {
        summary.children.push(this.summarize_(children[i]));
      }
    }
    return summary;
  };

  jasmine.WebrReporter.prototype.results = function() {
    return this.results_;
  };

  jasmine.WebrReporter.prototype.resultsForSpec = function(specId) {
    return this.results_[specId];
  };

  //noinspection JSUnusedLocalSymbols
  jasmine.WebrReporter.prototype.reportRunnerResults = function(runner) {
    this.finished = true;

    var results = runner.results(),
        specs = runner.specs(),
        duration = ((new Date).getTime() - this.startedAt) / 1000

    var suites = runner.topLevelSuites();
    for (var i = 0; i < suites.length; i++) {
      var suite = suites[i];
      this.suites_.push(this.summarize_(suite));
    }


    $id('totals').innerHTML = $template(
      "{{examples}}, {{failures}}", {
        examples: $plural(specs.length, "example"),
        failures: $plural(results.failedCount, "failure")
    })
    
    $id('duration').innerHTML = $template(
      "Finished in {{duration}} seconds", {
        duration: duration
      }
    )

    var self = this
    var sys = require('sys')

    function walk(arr) {
      var html = []
      arr.forEach(function(val, idx) {
        if (val.type == 'suite')
          html.push(formatGroup(val))
        if (val.type == 'spec')
          html.push(specPassed(val) ? formatPassed(val) : formatFailed(val))
      })
      return html.join('')
    }

    function specPassed(data) {
      var result = self.resultsForSpec(data.id), 
          messages = result.messages,
          len = messages.length
      for (var i = 0; i < len; i++)
        if (!messages[i].passed())
          return false
      return true
    }

    function formatFailed(data) {
      var t = $id('template_example_failed').innerHTML
      return $template(t, {
        name: data.name,
        items: formatMessages(self.resultsForSpec(data.id).messages)
      })
    }

    function formatPassed(data) {
      var t = $id('template_example_passed').innerHTML
      return $template(t, { name: data.name })
    }
    
    function formatGroup(data) {
      var t = $id('template_group').innerHTML
      return $template(t, {
        name: data.name,
        result: self.suites()[data.id].result,
        group_content: walk(data.children)
      })
    }

    function formatMessages(data) {
      var html = [], t = $id('template_example_failed_item').innerHTML
      data.forEach(function(val, idx, arr) {
        html.push($template(t, {
          message: $safe(val.toString()),
          backtrace: $safe((val.trace && val.trace.stack) || '')
        }))
      })
      return html.join('')
    }

    $id('header').className = results.failedCount ? 'failed' : 'passed'
    
    $append('results', walk(self.suites()))
    $class('template').forEach(function(node) {
      node.parentNode.removeChild(node)
    })
  };

  //noinspection JSUnusedLocalSymbols
  jasmine.WebrReporter.prototype.reportSuiteResults = function(suite) {
    this.suites_[suite.id] = {
      result: suite.results().failedCount > 0 ? "failed" : "passed"
    }
    // function keys(obj) {
    //   var ks = []
    //   for (var k in obj) ks.push(k)
    //   return ks.join(', ')
    // }
    // 
    // var sys = require('sys')
    // sys.puts(keys(suite))
    // sys.puts(suite.results().passed())
  };

  //noinspection JSUnusedLocalSymbols
  jasmine.WebrReporter.prototype.reportSpecResults = function(spec) {
    this.results_[spec.id] = {
      messages: spec.results().getItems(),
      result: spec.results().failedCount > 0 ? "failed" : "passed"
    };
  };

  jasmine.WebrReporter.prototype.log = function(str) {
  };

  jasmine.WebrReporter.prototype.resultsForSpecs = function(specIds){
    var results = {};
    for (var i = 0; i < specIds.length; i++) {
      var specId = specIds[i];
      results[specId] = this.summarizeResult_(this.results_[specId]);
    }
    return results;
  };

  jasmine.WebrReporter.prototype.summarizeResult_ = function(result){
    var summaryMessages = [];
    var messagesLength = result.messages.length;
    for (var messageIndex = 0; messageIndex < messagesLength; messageIndex++) {
      var resultMessage = result.messages[messageIndex];
      summaryMessages.push({
        text: resultMessage.type == 'log' ? resultMessage.toString() : jasmine.undefined,
        passed: resultMessage.passed ? resultMessage.passed() : true,
        type: resultMessage.type,
        message: resultMessage.message,
        trace: {
          stack: resultMessage.passed && !resultMessage.passed() ? resultMessage.trace.stack : jasmine.undefined
        }
      });
    }

    return {
      result : result.result,
      messages : summaryMessages
    };
  };

  
})();