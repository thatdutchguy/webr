module Webr::Jasmine
  class Browser < Webr::Browser
    def initialize(format)
      super()
      @portal.require_paths << "#{Webr::HOME_PATH}/ext"
      @portal.require_paths << "#{Webr::HOME_PATH}/ext/jsdom/lib"
      @portal.html = "<html><head></head><body></body></html>"
      @scripts << "#{Webr::HOME_PATH}/ext/jasmine/lib/jasmine.js"
      @env["WebrReporter"] = Reporter[format]
    end
    
    def start
      @scripts << "#{Webr::HOME_PATH}/js/jasmine-start.js"
      super
    end
    
  end
end