module Webr::Jasmine
  module Reporter
    class Base
      def initialize(jasmine)
        @jasmine = jasmine
        @started = false
        @started_at = nil
        @finished = false
        @finished_at = nil
      end

      def reportRunnerStarting(runner)
        @started = true
        @started_at = DateTime.now
      end

      def reportRunnerResults(runner)
        @finished_at = DateTime.now
        @finished = true
      end

      def reportSuiteResults(suite)
      end

      def reportSpecStarting(spec)
      end

      def reportSpecResults(spec)
      end

      def log(s)
      end
    end
    
    def self.[](name)
      pascalized_name = name.gsub(/(_|^)(\w)/) {$2.upcase}
      if Webr::Jasmine::Reporter.const_defined?(pascalized_name)
        Webr::Jasmine::Reporter.const_get(pascalized_name)
      else
        raise "Undefined reporter: #{name}"
      end
    end

    require 'webr/jasmine/reporter/html'
    require 'webr/jasmine/reporter/console'
  end
end
