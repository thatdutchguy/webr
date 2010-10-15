module Webr
  class Portal
    attr_accessor :scripts, :html, :root, :require_paths, :options
    
    def initialize
      @scripts = []
      @require_paths = []
      @options = {}
    end

  end
end