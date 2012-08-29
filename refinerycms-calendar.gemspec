# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-calendar'
  s.authors           = ['Joe Sak', 'Philip Arndt']
  s.version           = '2.0.0'
  s.description       = 'Ruby on Rails Calendar extension for Refinery CMS'
  s.date              = '2012-04-23'
  s.summary           = 'Calendar extension for Refinery CMS'
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  # Runtime dependencies
  s.add_dependency    'refinerycms-core',     '~> 2.1.0.dev'
  
  # Development dependencies (usually used for testing)
  # s.add_development_dependency 'refinerycms-testing', '~> 2.0.3'

end
