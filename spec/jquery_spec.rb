require 'spec/spec_helper'

context "runtime with htmlparser and jsdom loaded" do
  before(:all) do
    @runtime = Webr::Runtime.new
    @context = @runtime.context
    @context["require"].call(HTMLPARSER_PATH)
    @context["require"].call(JSDOM_PATH)
  end
  
  it "loads jquery" do
    lambda { @runtime.load('./spec/jquery_run.js') }.should_not raise_error
    @context['window']['jQuery'].should_not be_nil
  end
end
