module Webr::Jasmine
  module Reporter
    def self.[](name)
      pascalized_name = name.gsub(/(_|^)(\w)/) {$2.upcase}
      if Webr::Jasmine::Reporter.const_defined?(pascalized_name)
        Webr::Jasmine::Reporter.const_get(pascalized_name)
      else
        raise "Undefined reporter: #{name}"
      end
    end
    
    require 'webr/jasmine/reporter/base'
    require 'webr/jasmine/reporter/html'
    require 'webr/jasmine/reporter/console'
  end
end
