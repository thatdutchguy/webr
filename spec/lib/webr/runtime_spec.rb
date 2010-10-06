require 'spec/spec_helper'

context "runtime" do
  before(:each) do
    @runtime = Webr::Runtime.new
    @context = @runtime.context
  end
  
  it "exposes the require method to the context" do
    @context["require"].should_not be_nil
  end
  
  it "doesn't expose the createRequire method" do
    @context["createRequire"].should be_nil
  end
  
  it "loads a module" do
    exports = nil
    lambda { exports = @context["require"].call('./spec/sample') }.should_not raise_error
    exports.sample.should_not be_nil
    exports.sample.hello.should == "world"
  end
  
  it "caches a loaded module" do
    exports = nil
    lambda { @context["require"].call('./spec/sample') }.should_not raise_error
    lambda { exports = @context["require"].call("sample") }.should_not raise_error
    exports.sample.should_not be_nil
    exports.sample.hello.should == "world"
  end
  
  context "setTimeout" do
    it "is exposed" do
      @context["setTimeout"].should_not be_nil
    end

    it "calls the callback" do
      (callback = {}).should_receive(:call).with("foo")
      @context["setTimeout"].call(lambda { callback.call("foo") }, 10)
      sleep 0.01
    end
  end
  
  context "clearTimeout" do
    it "is exposed" do
      @context["clearTimeout"].should_not be_nil
    end
    
    it "stops the callback from being executed" do
      (callback = {}).should_receive(:call).once
      handle = @context["setTimeout"].call(lambda { callback.call }, 10)
      @context["clearTimeout"].call(handle)
      callback.call
      sleep 0.015
    end
  end
  
  context "setInterval" do
    it "is exposed" do
      @context["setInterval"].should_not be_nil
    end
    
    it "periodically executes a callback" do
      (callback = {}).should_receive(:call).twice
      handle = @context["setInterval"].call(lambda { callback.call }, 10)
      sleep 0.025
      @context["clearInterval"].call(handle)
    end
  end
  
  context "clearInterval" do
    it "is exposed" do
      @context["clearInterval"].should_not be_nil
    end
    
    it "stops the interval" do
      (callback = {}).should_receive(:call).twice
      handle = @context["setInterval"].call(lambda { callback.call }, 10)
      sleep 0.025
      @context["clearInterval"].call(handle)
      sleep 0.025
    end
  end
  
  
end