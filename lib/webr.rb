$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'v8'

module Webr
  VERSION = "0.0.0"

  SCRIPT_PATH = "./js"
  MODULE_PATH = "#{SCRIPT_PATH}/modules"
  
  require 'webr/binding'
  require 'webr/process'
  require 'webr/runtime'
  require 'webr/browser'
end