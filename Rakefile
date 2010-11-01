require 'rubygems'
require 'bundler/setup'
require 'webr'

desc 'Initialize environment'
task :init do
  puts ""
  puts "Initializing submodules"
  puts ""
  sh "git submodule init"
  sh "git submodule update"
end

Bundler::GemHelper.install_tasks

for file in Dir['tasks/*.rake']
  load file
end

