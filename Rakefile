require 'rubygems'
require 'lib/webr'

manifest = Rake::FileList.new
%w(app bin js lib spec tasks ext/jsdom/lib ext/node-htmlparser/lib).each do |dir|
  manifest.add "#{dir}/**/*"
end
manifest.add 'Rakefile'
manifest.add 'README.md'
manifest.add 'webr.gemspec'
manifest.add 'ext/jasmine/lib/jasmine.js'

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
  s.add_dependency('rednode', '>= 0.1.0')
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
