require 'spec/spec_helper'

context "runtime" do
  before(:each) do
    @runtime = Webr::Runtime.new
  end
  
  it "exposes the require method to the context" do
    @runtime.context["require"].should_not be_nil
  end
  
  it "doesn't expose the createRequire method" do
    @runtime.context["createRequire"].should be_nil
  end
  
  it "loads a module" do
    exports = nil
    lambda { exports = @runtime.context["require"].call('./spec/sample') }.should_not raise_error
    exports.sample.should_not be_nil
    exports.sample.hello.should == "world"
  end
  
  it "caches a loaded module" do
    exports = nil
    lambda { @runtime.context["require"].call('./spec/sample') }.should_not raise_error
    lambda { exports = @runtime.context["require"].call("sample") }.should_not raise_error
    exports.sample.should_not be_nil
    exports.sample.hello.should == "world"
  end
  
end