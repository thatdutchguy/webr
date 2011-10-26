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

    it "loads jasmine" do
      @browser.env['jasmine'].should_not be_nil
    end
  end

end