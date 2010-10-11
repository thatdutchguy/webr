require 'spec/spec_helper'

context "browser" do
  before(:each) do
    @browser = Webr::Browser.new
  end
  
  it "loads a web page" do
    lambda { @browser.open('./spec/sample.html') }.should_not raise_error
    @browser.context["window"].should_not be_nil
    @browser.context["window"]["document"].should_not be_nil
    @browser.context.eval('window.document.getElementById("foo").innerHTML').should == "bar"
  end

  it "loads a web page and executes scripts" do
    lambda { @browser.open('./spec/sample.html') }.should_not raise_error
    @browser.context["fooBar"].should == "baz"
  end
  
end