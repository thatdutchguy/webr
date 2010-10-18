module Webr
  class Portal
    attr_accessor :scripts, 
                  :html, 
                  :root, 
                  :require_paths, 
                  :options,
                  :env
    
    def initialize(node)
      @node = node
      @env = node.engine
      @scripts = []
      @require_paths = []
      @options = {}
    end

  end
end