module Webr
  class Browser
    attr_reader :runtime, :env, :scripts

    def initialize
      @runtime = Webr::Runtime.new("#{SCRIPT_PATH}/webr.js")
      @portal = @runtime.portal

      @portal.require_paths << "#{Webr::HOME_PATH}/ext"
      @portal.require_paths << "#{Webr::HOME_PATH}/ext/request"
      @portal.require_paths << "#{Webr::HOME_PATH}/ext/jsdom/lib"
      @portal.html = "<html><head></head><body></body></html>"

      # not so nice
      @env = @portal.env
      @scripts = @portal.scripts
    end

    def open(file_or_url)
      path = File.expand_path(file_or_url)
      @portal.root = File.dirname(path)
      @portal.html = File.new(path).read
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