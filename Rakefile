require 'rubygems'

desc 'Initialize environment'
task :init do
  puts ""
  puts "Initializing submodules"
  puts ""
  sh "git submodule init"
  sh "git submodule update"
end

for file in Dir['tasks/*.rake']
  load file
end
