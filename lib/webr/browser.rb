module Webr
  class Browser
    attr_reader :runtime, :context
    
    def initialize
      @runtime = Webr::Runtime.new
      @context = @runtime.context
      @context["require"].call("./ext/node-htmlparser/lib/node-htmlparser")
      @context["require"].call("./ext/jsdom/lib/jsdom")
    end

    # for opening a 'web page'
    def open(file_name)
      root = File.dirname(file_name)
      puts "loading: #{file_name}, root #{root}"
      html = File.new(file_name).read
      @context["jsdom"] = @context.eval('require("jsdom").jsdom')
      @context["window"] = @context["jsdom"].call(html)["createWindow"].call()
      # hack for jQuery
      @context.eval('document = window.document')
      @context.eval('navigator = window.navigator')
      @context.eval('location = window.location')
      @context.eval('document.location = window.location')
      # hack: run scripts
      list = @context.eval('window.document.getElementsByTagName("script")')
      0.upto(list["length"]-1) do |i|
        src = @context.eval('(function(list, i) { return list.item(i).getAttribute("src") })').call(list, i)
        if src.chomp.empty?
          text = @context.eval('(function(list, i) { return list.item(i).innerHTML })').call(list, i)
          @context.eval('(function(list, i, text) { list.item(i).text = text })').call(list, i, text)
        else
          src = "#{root}/#{src}" unless src.start_with?("http")
          @context.eval('(function(list, i, src) { return list.item(i).src = src })').call(list, i, src)
        end
      end
    end
    
    def console
      $stdout.print("> ")
      s = gets
      exit if s.chomp == "quit"
      begin
        puts @context.eval(s)
      rescue V8::JSError => e
        puts "JS Error: #{e.message}"
        puts e.backtrace
        puts "===="
      end
      console
    end
    
  end
  
end