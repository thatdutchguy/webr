module Webr::Binding
  class Stdout
    def initialize(context)
      @context = context
    end

    def write(msg)
      $stdout.write(msg)
    end

    def writeln(msg)
      $stdout.puts(msg)
    end    
  end
end
