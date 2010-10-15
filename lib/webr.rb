require 'rubygems'

$:.unshift(File.dirname(__FILE__) + '/../ext/rednode/lib')
require 'rednode'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))



module Webr
  VERSION = "0.0.1"

  HOME_PATH = File.expand_path(File.dirname(__FILE__) + '/../')
  SCRIPT_PATH = "#{HOME_PATH}/js"

  require 'webr/runtime'
  require 'webr/portal'
  require 'webr/browser'
end