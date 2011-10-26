module Webr::Jasmine
  class Browser < Webr::Browser
    def initialize(format)
      super()
      @scripts << "#{Webr::HOME_PATH}/ext/jasmine/lib/jasmine.js"
      @env["WebrReporter"] = Reporter[format]
    end

    def start
      @scripts << "#{Webr::HOME_PATH}/js/jasmine-start.js"
      super
    end

  end
end