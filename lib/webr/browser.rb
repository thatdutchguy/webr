module Webr
  class Browser
    attr_reader :runtime, :env, :scripts, :require_paths, :options
    
    def initialize
      @runtime = Webr::Runtime.new("#{SCRIPT_PATH}/webr.js")
      @portal = @runtime.portal
      # not so nice
      @env = @portal.env
      @scripts = @portal.scripts
      # @require_paths = @portal.require_paths
      # @options = @portal.options
    end

    def root
      @portal.root
    end
    def root=(root)
      @portal.root = root
    end

    def html
      @portal.html
    end
    def html=(html)
      @portal.html = html
    end
    
    def start
      @runtime.start
    end
    
  end
end