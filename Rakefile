require 'rubygems'
require 'lib/webr'

manifest = Rake::FileList.new('**/*')
manifest.exclude '*.log*'
manifest.exclude 'ext/jasmine/*'
manifest.exclude 'ext/jsdom/*'
manifest.exclude 'ext/node-htmlparser/*'
manifest.exclude 'ext/jquery/*'
manifest.exclude 'tmp/*'
manifest.exclude 'webr*.gem'

Gem::Specification.new do |s|
  $gemspec = s
  s.name = 'webr'
  s.version = Webr::VERSION
  s.summary = "Magnolia Bookshelf"
  s.description = "Magnolia Bookshelf"
  s.authors = ["Daniël van de Burgt"]
  s.email = "secretlymexico@gmail.com"
  s.require_paths = ['lib']
  s.executables = ["webr"]
  s.files = manifest.to_a
  s.add_dependency('therubyracer', '>= 0.8.0.pre2')
  s.add_dependency('eventmachine')
  s.add_dependency('optitron')
end

desc "Build gem"
task :gem do
  Gem::Builder.new($gemspec).build
end

desc "Build the gemspec"
task :gemspec do
  File.open("#{$gemspec.name}.gemspec", 'w') do |f|
    f.write($gemspec.to_ruby)
  end
end

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
