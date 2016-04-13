lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'messenger/bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'messenger-bot-ruby'
  spec.version       = Messenger::Bot::VERSION
  spec.authors       = ['Matteo Gavagnin', 'Alexander Tipugin']
  spec.email         = ['m@macteo.it', 'atipugin@gmail.com']
  spec.licenses      = ['MIT']
  spec.summary       = "Ruby wrapper for Messenger's Bot API"
  spec.homepage      = 'https://github.com/macteo/messenger-bot-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httmultiparty', '~> 0.3'
  spec.add_dependency 'persistent_httparty', '~> 0.1'
  spec.add_dependency 'virtus', '~> 1.0'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'cuba', '~> 3.6'
  spec.add_development_dependency 'multi_json', '~> 1.11'
end
