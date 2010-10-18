module Rednode
  class Process
    attr_accessor :webr
  end
end

module Webr
  class Runtime
    attr_reader :node, :process, :portal
    
    def initialize(script)
      @node = Rednode::Node.new(script)
      @process = Rednode::Process.new(@node)

      @portal = Portal.new(@node)
      @process.webr = @portal
    end

    def start
      @node.start(@process)
    end
  end
end