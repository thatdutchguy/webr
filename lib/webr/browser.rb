module Webr
  class Browser
    attr_reader :runtime, :portal
    
    def initialize
      @portal = Portal.new
      @runtime = Webr::Runtime.new("#{SCRIPT_PATH}/webr.js", @portal)
    end
    
    def start
      @runtime.start
    end
    
  end
end