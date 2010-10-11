module Webr::Binding
  class Stdout
    def initialize(context)
      @context = context
    end

    def write
      lambda do |msg|
        $stdout.write(msg)
      end
    end

    def writeln
      lambda do |msg|
        $stdout.puts(msg)
      end
    end    
  end
end
