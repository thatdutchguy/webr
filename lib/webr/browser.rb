module Webr
  class Browser
    attr_reader :runtime, :env
    attr_accessor :scripts, :html, :root, :require_paths, :options
    
    def initialize
      @runtime = Webr::Runtime.new("#{SCRIPT_PATH}/webr.js")
      @portal = @runtime.portal
      # not so nice
      @env = @portal.env
      @scripts = @portal.scripts
      @html = @portal.html
      @root = @portal.root
      @require_paths = @portal.require_paths
      @options = @portal.options
    end
    
    def start
      @runtime.start
    end
    
  end
end