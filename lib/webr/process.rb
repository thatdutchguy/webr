module Webr
  class Process
    attr_reader :platform, :version, :stdout

    def initialize(context)
      @context = context
      @platform = "Webr"
      @version = Webr::VERSION
      @stdout = Webr::Binding['stdout'].new(@context)
    end
    
    def binding(name)
      obj = Webr::Binding[name]
      obj.new(@context) if obj
    end
  end
end