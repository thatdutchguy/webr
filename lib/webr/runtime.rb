module Rednode
  class Process
    attr_accessor :webr
  end
end

module Webr
  class Runtime
    attr_reader :node
    
    def initialize(script, portal)
      @node = Rednode::Node.new(script)
      @process = Rednode::Process.new(@node)
      @process.webr = portal
    end

    def start
      @node.start(@process)
    end
  end
end