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

      puts "Examples: #{specs.length}, Failure#{'s' unless results.failedCount == 1}: #{results.failedCount}"
      puts "Finished in #{"%0.4f" % (@finished_at - @started_at).to_f}s"
    end
  end

end
