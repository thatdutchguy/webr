require 'webr'
require 'optitron'

module Webr
  
  class App < Optitron::CLI
    include ERB::Util # for the #h method

    desc "Run [file_name]"
    def browser(file_name)
      raise "No such file: #{file_name}" unless File.exist?(file_name)
      file = File.expand_path(file_name)
      root = File.expand_path(File.dirname(file))

      browser = Webr::Browser.new
      browser.open(file_name)
      browser.start
    end
    
    desc "Run [file_name] using jasmine and report"
    opt "format", :in => %w(html console), :default => 'console'
    def jasmine(file_name)
      raise "No such file: #{file_name}" unless File.exist?(file_name)
      files = []
      if File.directory?(file_name)
        root = File.expand_path(file_name)
        files += Dir["#{root}/*_spec.js"]
      else
        files << File.expand_path(file_name)
        root = File.dirname(File.expand_path(file_name))
      end

      format = params["format"]

      begin
        browser = Webr::Jasmine::Browser.new(format)
        browser.root = root
        files.each do |file|
          browser.scripts << file
        end
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
