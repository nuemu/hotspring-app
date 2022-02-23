source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Main
ruby '2.7.4'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'puma', '~> 5.0'
gem 'jbuilder', '~> 2.7'

# DB:postgresql
gem 'pg', '~> 1.1'

#time-zone
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#Frontend
gem 'webpacker', '~> 5.0'

#Lint
gem 'rubocop', require: false
gem 'rubocop-rails', require: false

group :development, :test do
  #debug tool
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
end
