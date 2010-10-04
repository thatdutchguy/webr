require 'spec/spec_helper'

context "runtime" do
  context "in general" do
    before(:each) do
      @runtime = Webr::Runtime.new
      @context = @runtime.context
    end

    it "loads node-htmlparser" do
      exports = nil
      lambda { exports = @runtime.context["require"].call(HTMLPARSER_PATH) }.should_not raise_error
      exports["Parser"].should_not be_nil
    end
  end

  context "with htmlparser loaded" do
    before(:each) do
      @runtime = Webr::Runtime.new
      @context = @runtime.context
      @htmlparser = @context["require"].call(HTMLPARSER_PATH) 
    end
    
    it "parses html" do
      (callback = {}).should_receive(:call).with(nil, an_instance_of(V8::Array))
      handler = @htmlparser["DefaultHandler"].new(lambda { |err, dom| callback.call(err, dom) })
      parser  = @htmlparser["Parser"].new(handler)
      parser.parseComplete("<p>Test</p>")
      handler.dom[0].name.should == "p"
      handler.dom[0].children[0].data.should == "Test"
    end

    it "loads jsdom" do
      exports = nil
      lambda { exports = @context["require"].call(JSDOM_PATH) }.should_not raise_error
      exports.jsdom.should_not be_nil
    end
  end
  
end