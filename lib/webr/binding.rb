module Webr
  module Binding
    require 'webr/binding/fs'
    require 'webr/binding/evals'
    require 'webr/binding/stdout'
    
    def self.[](name)
      binding = name.gsub(/^\w/) { |c| c.upcase }
      ::Webr::Binding.const_get(binding)
    end
    
  end
end