require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe Webr::Jasmine::Browser do
  
  it "requires an existing format to instantiate" do
    lambda { Webr::Jasmine::Browser.new('foo') }.should raise_error("Undefined reporter: foo")
    class Webr::Jasmine::Reporter::FooBar; end
    lambda { Webr::Jasmine::Browser.new('foo_bar') }.should_not raise_error
  end
  
  context "in general" do
    before(:all) do
      @browser = Webr::Jasmine::Browser.new('base')
      @browser.start
    end

    it "has loaded jsdom and this has a dom" do
      env = @browser.env
      env['window'].should_not be_nil
      env['window']['document'].should_not be_nil
      env.eval('var p = document.createElement("p")')
      env.eval('document.body.appendChild(p)')
      env.eval('document.getElementsByTagName("p").length').should == 1
      env.eval('p.parentNode.removeChild(p)')
      env.eval('document.getElementsByTagName("p").length').should == 0
    end
    
    it "has loaded node-htmlparser and thus can set innerHTML" do
      env = @browser.env
      env.eval('var div = document.createElement("div")')
      env.eval('div.innerHTML = "foobar"')
      env["div"]['innerHTML'].should == 'foobar'
    end

    it "loads jasmine" do
      @browser.env['jasmine'].should_not be_nil
    end
  end
    
end