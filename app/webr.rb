require 'webr'
require 'optitron'

module Webr
  class App < Optitron::CLI
    desc "Run [file_name] with jasmine loaded"
    def jasmine(file_name, format = 'html')
      raise "No such file: #{file_name}" unless File.exist?(file_name)
      root = File.expand_path(File.dirname(file_name))
      home = File.expand_path(File.join(File.dirname(__FILE__), '..'))

      browser = Webr::Browser.new
      browser.portal.html = File.new("#{home}/app/js/jasmine/runner.html").read
      browser.portal.root = root
      browser.portal.require_paths << "#{home}/app/js/htmlparser"
      browser.portal.require_paths << "#{home}/app/js/dom"
      browser.portal.scripts << "#{home}/app/js/jasmine/jasmine.js"
      browser.portal.scripts << "#{home}/app/js/jasmine/jasmine-html.js"
      browser.portal.scripts << file_name
      browser.portal.scripts << "#{home}/app/js/jasmine/jasmine-start.js"
      browser.portal.options[:outputDocument] = true if format == 'html'
      browser.start
    end
  end
  
  App.dispatch
end
