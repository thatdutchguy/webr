module Webr
  class Browser
    attr_reader :runtime, :context
    
    def initialize
      @runtime = Webr::Runtime.new
      @context = @runtime.context
      @context["require"].call("./ext/node-htmlparser/lib/node-htmlparser")
      @context["require"].call("./ext/jsdom/lib/jsdom")
    end

    def load(file_name)
      @context["global"] = @context.scope
      @runtime.load(file_name)
    end

    # for opening a 'web page'
    def open(file_name)
      root = File.dirname(file_name)
      html = File.new(file_name).read

      define_browser = @context.load("#{SCRIPT_PATH}/browser_init.js")
      define_browser.call(@context.scope, html)

      run_scripts = @context.load("#{SCRIPT_PATH}/browser_loadscripts.js")
      run_scripts.call(@context.scope, root)
    end
  end
  
end