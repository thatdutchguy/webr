module Webr
  
  SCRIPT_PATH = './js'
  
  class ProcessObject
    attr_reader :platform, :version, :stdout, :fs

    def initialize(context)
      @context = context
      
      @platform = "Webr"
      @version = "0.0.0"

      @stdout = StdOutObject.new
      @fs = FsObject.new
    end
    
    def binding(binding_name)
      if binding_name == "evals"
        EvalsObject.new(@context)
      end
    end
    
  end

  class EvalsObject
    attr_reader :Script
    
    def initialize(context)
      @Script = ScriptObject.new(context)
    end
  end
  
  class ScriptObject
    def initialize(context)
      @context = context
    end
    
    def runInNewContext(src, sandbox, file_name)
      @context.eval(src, sandbox)
    end
  end
  
  class FsObject
    def readFile(file_name, callback)
      callback.call(nil, File.new(file_name).read)
    end
  end
  
  class StdOutObject
    def write(msg)
      $stdout.write(msg)
    end
    
    def writeln(msg)
      $stdout.puts(msg)
    end    
  end

  class Runtime
    attr_reader :context
    
    def initialize
      @context = V8::Context.new
      @context["process"] = ProcessObject.new(@context)
      @context["__filename"] = __FILE__
      @context["__dirname"] = File.dirname(__FILE__)
      @context["module"] = @context["Object"].new
      @context["exports"] = @context["Object"].new

      return_module      = lambda { |namespace, trail| module_read(namespace, trail) }
      return_module_path = lambda { |namespace, trail| module_path(namespace, trail) }

      define_require = @context.load('js/require.js')
      @context["require"] = define_require.call(@context.scope, @context["Object"].new, return_module, return_module_path)
    end
    
    def load(file_name)
      path = File.expand_path(file_name)
      dir  = File.dirname(path)
      @context["__filename"] = path
      @context["__dirname"]  = dir
      
      # stubbing out some stuff
      @context["setTimeout"] = lambda do |callback, timeout| 
        puts "::setTimeout #{timeout}"
        callback.call()
      end
      @context["setInterval"] = lambda do |callback, interval|
        puts "::setInterval #{interval}"
      end
      @context["clearTimeout"] = lambda do
        puts "::clearTimeout"
      end
      @context["clearInterval"] = lambda do
        puts "::clearInterval"
      end
      
      @context.load(file_name)
    end    
    
    def module_read(namespace, trail = [])
      trail = trail.to_a
      paths = []
      paths << "#{SCRIPT_PATH}/#{namespace}.js"
      paths << "#{namespace}.js"
      paths << "#{namespace}/index.js"
      paths << "#{trail.join('/')}/#{namespace}.js"
      paths << "#{trail.join('/')}/#{namespace}/index.js"

      paths.each do |p|
        return File.new(p).read if File.exists?(p)
      end
      
      raise "Can't resolve namespace: #{namespace}"
    end
    
    def module_path(namespace, trail = [])
      if File.directory?("#{trail.join('/')}/#{namespace}")
        return namespace
      else
        return File.dirname(namespace)
      end
    end
    
  end
    
end