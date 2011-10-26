module Webr::Jasmine::Reporter
  class Console < Webr::Jasmine::Reporter::Base
    def initialize(jasmine)
      super

      @fail_count = 0
    end


    def reportRunnerResults(runner)
      super(runner)
      summarize(runner)
    end

    def reportSpecResults(spec)
      super
      if spec.results.passed
        $stdout.write('.')
      else
        $stdout.write('F')
      end
    end


    def summarize(runner)
      puts "\n"
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
        puts "\nFailures:" if @fail_count == 0
        @fail_count += 1
        puts "  #{@fail_count}) #{spec.getFullName}"
        spaces = " " * (4 + @fail_count.to_s.size)
        spec.results.getItems.each do |item|
          unless item.passed
            backtrace = if error = item['error']
              error.respond_to?(:stack) ? error.stack : error
            else
              item.trace.stack
            end
            puts spaces + item.to_s
            filter_backtrace(backtrace).each_line do |line|
              puts spaces + line
            end
            puts ""
          end
        end
      end
    end

    def render_summary(runner)
      suites  = runner.suites
      specs   = runner.specs
      results = runner.results

      # #TODO: Change this. This method is private in Ruby 1.9 - which is a little weird.
      hours, minutes, seconds, fraction = Date.send(:day_fraction_to_time, @finished_at - @started_at)
      time_taken = "%0.8f" % (hours*60*60 + minutes*60 + seconds + fraction.to_f)

      puts "Finished in #{time_taken}s"
      puts "Examples: #{specs.length}, Failure#{'s' unless results.failedCount == 1}: #{results.failedCount}"
    end
  end

end
