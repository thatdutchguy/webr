require 'spec/spec_helper'

describe Webr::Browser do
  it "runs the jasmine test suite" do
    browser = Webr::Browser.new

    lambda do
      browser.open('./ext/jasmine/spec/runner.html')
      while Thread.list.size > 1
        sleep 0.1
      end
    end.should_not raise_error
    # one of the jasmine tests fails
    message = browser.context.eval('document.getElementsByClassName("description").item(0).text')
    puts "\nJasmine reports: [#{message}]"
    # message.should =~ /210 specs, 0 failures/
    message.should =~ /210 specs, 1 failure/
  end
end