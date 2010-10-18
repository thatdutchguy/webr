module Webr::Jasmine::Reporter
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
end