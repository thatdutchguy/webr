$:.push File.expand_path("../lib", __FILE__)
require 'rake'
require 'webr'

Gem::Specification.new do |s|
  s.name = 'webr'
  s.version = Webr::VERSION
  s.summary = "Pain-free javascript testing"
  s.description = "Test your javascript with no server, no browser, just pleasure."
  s.authors = ["Daniël van de Burgt"]
  s.email = "secretlymexico@gmail.com"
  s.require_paths = ['lib']
  s.executables = ["webr"]
  s.add_dependency('therubyracer', '>= 0.8.0.pre3')
  s.add_dependency('rednode', '>= 0.1.0')
  s.add_dependency('eventmachine')
  s.add_dependency('optitron')
  s.add_development_dependency('rspec')

  manifest = Rake::FileList.new
  %w(app bin js lib spec jspec tasks ext/jsdom/lib ext/node-htmlparser/lib).each do |dir|
    manifest.add "#{dir}/**/*"
  end
  manifest.add 'Rakefile'
  manifest.add 'README.md'
  manifest.add 'webr.gemspec'
  manifest.add 'ext/jasmine/lib/jasmine.js'
  s.files = manifest.to_a
end
