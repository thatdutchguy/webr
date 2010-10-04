require 'spec/spec_helper'

context "runtime" do
  before(:all) do
    @runtime = Webr::Runtime.new
  end
  
  it "loads jsdom" do
    exports = nil
    lambda { exports = @runtime.context["require"].call(JSDOM_PATH) }.should_not raise_error
    exports.jsdom.should_not be_nil
  end
  
end