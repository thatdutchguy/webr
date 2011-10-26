require 'spec_helper'

describe Webr::Jasmine::Reporter::Console do

  it "reports" do
    output = ''
    $stdout.stub(:write) { |*a| output.<<(*a) }
    results = []
    results.stub(:failedCount) { 0 }
    runner = mock(:Runner, :suites => [], :specs => [], :results => results, :topLevelSuites => [])
    reporter = Webr::Jasmine::Reporter::Console.new(nil)
    reporter.reportRunnerStarting(runner)
    reporter.reportRunnerResults(runner)
    reporter.render_summary(runner)
    output.should match /Examples: 0, Failures: 0\nFinished in/
  end

end


