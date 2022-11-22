spec = Gem::Specification.new do |s|
  s.name = 'dalli-store-extensions'
  s.version = '0.0.2'
  s.summary = "Rails Dalli Store extensions providing matched deletion"
  s.description = %{Provides delete_matched for Dalli store in Rails 3}
  s.files = Dir['lib/**/*.rb'] + Dir['spec/**/*.rb']
  s.require_path = 'lib'
  s.autorequire = 'builder'
  s.extra_rdoc_files = Dir['[A-Z]*']
  s.rdoc_options << '--title' <<  'dalli-store-extensions -- matched deletion'
  s.author = "James Kassemi"
  s.email = "jkassemi@gmail.com"
  s.homepage = "http://tweekedideas.com"
end
