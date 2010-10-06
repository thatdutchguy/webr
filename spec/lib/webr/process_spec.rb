require 'spec/spec_helper'

context "process" do
  before(:each) do
    @runtime = Webr::Runtime.new
    @process = @runtime.context["process"]
  end

  it "initializes" do
    @process.should_not be_nil
  end
  
  it "exposes stdout" do
    @process.stdout.should_not be_nil
  end
  
  it "returns a binding" do
    module Webr::Binding
      class Foo; end
    end
    Webr::Binding::Foo.should_receive(:new).with(@runtime.context)
    foo = @process.binding('foo')
  end
end