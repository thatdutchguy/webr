begin
  require 'rspec/core'
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ["-c", "-f progress"]
    t.pattern = 'spec/**/*_spec.rb'
  end
rescue LoadError => e
  puts "unable to run specs from rake. gem install rspec"
end
