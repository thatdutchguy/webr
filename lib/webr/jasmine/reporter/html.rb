module Webr::Jasmine::Reporter
  class Html < Webr::Jasmine::Reporter::Base
    include ERB::Util # for h
    
    def reportRunnerResults(runner)
      super(runner)
      puts summarize(runner)
    end

    def summarize(runner)
      css = render_css
      summary = render_summary(runner)
      results = render_results(runner.topLevelSuites)
      status = runner.results.failedCount > 0 ? 'failed' : 'passed'
      "<!DOCTYPE html><html><head><title>Jasmine results</title>#{css}</head><body></body><div class='report'><div id='header' class='#{status}'><h1>Jasmine Code Examples</h1>#{summary}<div id='results' class='results'>#{results}</div></div></html>"
    end
  
    def render_results(suites_or_specs)
      html = []
      suites_or_specs.each do |suite_or_spec|
        html << render_suite(suite_or_spec) if @jasmine.isSuite(suite_or_spec)
        html << render_spec(suite_or_spec)  if @jasmine.isSpec(suite_or_spec)
      end
      html.join
    end
  
    def render_suite(suite)
      result = suite_passed(suite) ? 'passed' : 'failed'
      content = render_results(suite.children)
      "<div class='group #{result}'><div class='group-name'>#{h(suite.description)}</div>#{content}</div>"
    end

    def suite_passed(suite)
      suite.results.getItems.each do |item|
        return false unless item.passed
      end
      true
    end
  
    def render_spec(spec)
      result = spec.results.passed ? 'passed' : 'failed'
      content = spec.results.passed ? '' : render_spec_failed(spec)
      "<div class='example #{result}'><div class='example-name'>#{h(spec.description)}</div>#{content}</div>"
    end

    def render_spec_failed(spec)
      html = []
      name = spec.description
      results = spec.results
      results.getItems.each do |item|
        unless item.passed
          unless item.passed
            backtrace = if error = item['error']
              error.respond_to?(:stack) ? textmate_backtrace(h(filter_backtrace(error.stack))) : h(error)
            else
              textmate_backtrace h(filter_backtrace(item.trace.stack))
            end
            html << "<div class='example-failure'><div class='message'><pre>#{h(item.to_s)}</pre></div><div class='backtrace'><pre>#{backtrace}</pre></div></div>"
          end
        end
      end
      html.join
    end

    def render_css
      <<-EOCSS
      <style>
        html, body {
          padding: 0;
          margin: 0;
        }
        body {
          font-size: 80%;
          font-family: "Lucida Grande", Helvetica, sans-serif;
        }
        #header {
          background: #000;
          color: #fff;
          height: 4em;
        }
        #header.passed {
          background-color: #65C400;
        }
        #header.failed {
          background-color: #c40d0d;
        }

        #header h1 {
          font-size: 1.8em;
          margin: 0 10px;
          padding: 10px;
          position: absolute;
        }

        .summary {
          float: right;
          margin: 0;
          padding: 5px 10px;
          right: 0;
          top: 0;
        }
        .summary p {
          margin: 0 0 0 2px;
        }
        .summary .totals {
          font-size: 1.2em;
        }

        #results {
          margin-bottom: 1em;
          padding-right: 10px;
        }

        .group {
          margin: 0 0 5px 10px;
          padding: 0 0 5px;
          font-size: 11px;
        }
        .group-name {
          background-color: #000;
          color: #fff;
          font-weight: bold;
          padding: 3px;
        }
        .group.failed .group-name {
          background-color: #c40d0d;
        }
        .group.passed .group-name {
          background-color: #65C400;
        }

        .example {
          margin: 5px 0 5px 5px;
          padding: 3px 3px 3px 18px;
        }
        .example.failed {
          background-color: #fffbd3;
          border-bottom: 1px solid #c40d0d;
          border-left: 5px solid #c40d0d;
          color: #C20000;
        }
        .example.passed {
          background-color: #DBFFB4;
          border-bottom: 1px solid #65C400;
          border-left: 5px solid #65C400;
          color: #3D7700;
        }
        .example .backtrace {
          color: #000;
        }

      </style>
      EOCSS
    end

    def render_summary(runner)
      suites  = runner.suites
      specs   = runner.specs
      results = runner.results
      
      hours, minutes, seconds, fraction = Date.day_fraction_to_time(@finished_at - @started_at)
      time_taken = "%0.8f" % (hours*60*60 + minutes*60 + seconds + fraction.to_f)

      totals = "Examples: #{specs.length}, Failure#{'s' unless results.failedCount == 1}: #{results.failedCount}"
      duration = "Finished in #{time_taken}s"
      "<div class='summary'><p class='totals'>#{totals}</p><p class='duration'>#{duration}</p></div></div>"
    end

    def textmate_backtrace(s)
      lines = []
      s.each_line do |line|
       lines << line.gsub(/(\/.*\.js):(\d*)/) { "<a href=\"txmt://open?url=file://#{File.expand_path($1)}&line=#{$2}\">#{$1}:#{$2}</a>" }
      end
      lines.join
    end
    
  end

end
