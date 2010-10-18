require 'webr'
require 'optitron'

module Webr
  class App < Optitron::CLI
    desc "Run [file_name] with jasmine loaded"
    opt "format", :in => %w(html console), :default => 'console'
    def jasmine(file_name)
      raise "No such file: #{file_name}" unless File.exist?(file_name)
      root = File.expand_path(File.dirname(file_name))
      home = File.expand_path(File.join(File.dirname(__FILE__), '..'))
      format = params["format"]

      browser = Webr::Browser.new
      browser.root = root
      browser.require_paths << "#{home}/app/js/htmlparser"
      browser.require_paths << "#{home}/app/js/dom"
      
      browser.scripts << "#{home}/app/js/jasmine/jasmine.js"
      browser.env["WebrReporter"] = Jasmine::Reporter[format]
      
      browser.scripts << file_name
      browser.scripts << "#{home}/app/js/jasmine/jasmine-start.js"

      browser.start
    end
  end
  
  App.dispatch
end
