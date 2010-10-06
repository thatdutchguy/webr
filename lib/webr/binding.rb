module Webr
  module Binding
    require 'lib/webr/binding/fs'
    require 'lib/webr/binding/evals'
    require 'lib/webr/binding/stdout'
    
    def self.[](name)
      binding = name.gsub(/^\w/) { |c| c.upcase }
      ::Webr::Binding.const_get(binding)
    end
    
  end
end