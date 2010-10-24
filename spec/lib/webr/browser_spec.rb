require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Webr::Jasmine::Browser do

  it "instantiates" do
    browser = Webr::Browser.new
  end

  context "in general" do
    before(:all) do
      @browser = Webr::Browser.new
      @browser.start
    end

    it "has loaded jsdom and thus has a dom" do
      env = @browser.env
      env['window'].should_not be_nil
      env['window']['document'].should_not be_nil
      document = env["document"].tap do |doc|
        p = doc.createElement("p")
        doc.body.appendChild(p)
        ps = doc.getElementsByTagName("p")
        ps.length.should == 1
        p.parentNode.removeChild(p)
        ps.length.should == 0 # live list
      end
    end

    it "has loaded node-htmlparser and thus can set innerHTML" do
      env = @browser.env
      env["document"].tap do |doc|
        div = doc.createElement('div')
        doc.body.appendChild(div)
        div["innerHTML"] = '<p>Test</p>'
        doc.getElementsByTagName('p')[0].innerHTML.should == "Test"
        div.parentNode.removeChild(div)
      end
    end
  end

  context "loading webpages" do
    before(:each) do
      @browser = Webr::Browser.new
    end
    
    it "loads a web page from a file" do
      @browser.open("#{DATA_PATH}/plain.html")
      @browser.start
      @browser.env["document"].tap do |doc|
        doc.getElementsByTagName('meta').tap do |meta|
          meta.length.should == 1
          meta[0].getAttribute('charset').should == "utf-8"
        end
        doc.getElementsByTagName('title').tap do |title|
          title.length.should == 1
          title[0].innerHTML.should == "Plain HTML"
        end
        doc.getElementsByTagName('h1').tap do |h1|
          h1.length.should == 1
          h1[0].innerHTML.should == "Plain"
        end
        doc.getElementsByTagName('p').tap do |p|
          p.length.should == 3
          p[0].innerHTML.should == "Foo"
          p[1].innerHTML.should == "Bar"
          p[2].innerHTML.should == "Baz"
        end
      end
    end

    it "loads a webpage containing embedded javascript from a file and executes the javascript" do
      @browser.open("#{DATA_PATH}/script-embedded.html")
      @browser.start
      @browser.env["hello"].should == "world"
      @browser.env["document"].tap do |document|
        h1    = document.getElementsByTagName('h1')[0]
        title = document.getElementsByTagName('title')[0]
        h1.innerHTML.should == title.innerHTML
      end
    end

    it "loads a webpage containing external javascript from a file and executes the javascript" do
      @browser.open("#{DATA_PATH}/script-external.html")
      @browser.start
      @browser.env["document"].tap do |document|
        h1    = document.getElementsByTagName('h1')[0]
        title = document.getElementsByTagName('title')[0]
        h1.innerHTML.should == title.innerHTML
      end
    end

    it "loads and executes the jasmine test suite" do
      pending "this actually works but takes over 10 seconds. Need to figure out why it's so slow."
      @browser.open("#{EXT_PATH}/jasmine/spec/runner.html")
      @browser.start
      @browser.env["jasmine"].should_not be_nil
    end

  end

end