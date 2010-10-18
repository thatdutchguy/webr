module Webr::Jasmine::Reporter
  class Console < Webr::Jasmine::Reporter::Base
    def reportRunnerResults(runner)
      super(runner)
      summarize(runner)
    end

    def summarize(runner)
      render_results(runner.topLevelSuites)
      puts "\n"
      render_summary(runner)
    end
  
    def render_results(suites_or_specs)
      suites_or_specs.each do |suite_or_spec|
        render_suite(suite_or_spec) if @jasmine.isSuite(suite_or_spec)
        render_spec(suite_or_spec)  if @jasmine.isSpec(suite_or_spec)
      end
    end

    def render_suite(suite)
      render_results(suite.children)
    end
  
    def render_spec(spec)
      unless spec.results.passed
        puts "\n"
        puts "FAILED:"
        puts spec.getFullName
        spec.results.getItems.each do |item|
          unless item.passed
            puts item.to_s
            puts item.trace.stack
          end
        end
      end
    end

    def render_summary(runner)
      suites  = runner.suites
      specs   = runner.specs
      results = runner.results

      hours, minutes, seconds, fraction = Date.day_fraction_to_time(@finished_at - @started_at)
      time_taken = "%0.8f" % (hours*60*60 + minutes*60 + seconds + fraction.to_f)

      puts "Examples: #{specs.length}, Failure#{'s' unless results.failedCount == 1}: #{results.failedCount}"
      puts "Finished in #{time_taken}s"
    end
  end

end
