
begin
  require 'rspec/core/rake_task'
  desc "run rspecs"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ["-c", "-f progress"]
    t.pattern = 'spec/**/*_spec.rb'
  end
rescue LoadError => e
  desc "run rspecs (I can't get the rspec/core/rake_task to load... bug in rspec?)"
  task :spec do
    puts "install rspec to run rake specs"
  end
end

task :default => :spec