require 'webr'
require 'optitron'

module Webr
  
  class App < Optitron::CLI
    include ERB::Util # for the #h method
    
    desc "Run [file_name] with jasmine loaded"
    opt "format", :in => %w(html console), :default => 'console'
    def jasmine(file_name)
      raise "No such file: #{file_name}" unless File.exist?(file_name)
      root = File.expand_path(File.dirname(file_name))
      home = File.expand_path(File.join(File.dirname(__FILE__), '..'))
      format = params["format"]

      begin
        browser = Webr::Jasmine::Browser.new(format)
        browser.root = root
        browser.scripts << file_name
        browser.start
      rescue Exception => e
        if format == 'html'
          puts "<pre>"
          puts h(e.message)
          puts h(e.backtrace.join("\n"))
          puts "</pre>"
        else
          raise
        end
      end
      
    end
  end
  
  App.dispatch
end
