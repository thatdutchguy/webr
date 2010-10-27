require File.expand_path(File.dirname(__FILE__) + '/../../../../spec_helper')

describe Webr::Jasmine::Reporter::Html do
  
  it "should create valid textmate links for a backtrace" do
    reporter = Webr::Jasmine::Reporter::Html.new(nil)
    reporter.textmate_backtrace("at [object Object].<anonymous> (/Users/Daniel/playground/webr/jspec/foo_spec.js:14:15)").should ==
                                "at [object Object].<anonymous> (<a href=\"txmt://open?url=file:///Users/Daniel/playground/webr/jspec/foo_spec.js&line=14\">/Users/Daniel/playground/webr/jspec/foo_spec.js:14</a>:15)"
    reporter.textmate_backtrace("at /Users/Daniel/.rvm/gems/ruby-1.8.7-p302/gems/rednode-0.1.0/ext/node/src/node.js:764:9").should ==
                                "at <a href=\"txmt://open?url=file:///Users/Daniel/.rvm/gems/ruby-1.8.7-p302/gems/rednode-0.1.0/ext/node/src/node.js&line=764\">/Users/Daniel/.rvm/gems/ruby-1.8.7-p302/gems/rednode-0.1.0/ext/node/src/node.js:764</a>:9"
  end
  
end


