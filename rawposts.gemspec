# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "rawposts"
  spec.version       = "0.9"
  spec.authors       = ["daviddong"]
  spec.email         = ["dqdongg@hotmail.com"]

  spec.summary       = "A portfolio style jekyll theme for writers"
  spec.homepage      = "https://gangdong.github.io/daviddong.github.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r!^(assets|_layouts|_includes|_sass|LICENSE|README|404.html|sitemap.xml)!i) }

  spec.add_runtime_dependency "jekyll", ">= 3.7.3"
  spec.add_runtime_dependency "jekyll-seo-tag", ">= 2.1.0"

  spec.add_development_dependency "bundler", "> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
end