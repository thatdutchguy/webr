module Webr::Binding
  class Evals
    attr_reader :Script
  
    def initialize(context)
      @Script = Script.new(context)
    end
  end

  class Script
    def initialize(context)
      @context = context
    end
  
    def runInNewContext
      lambda do |src, sandbox, file_name|
        @context.eval(src, sandbox)
      end
    end
  end
end