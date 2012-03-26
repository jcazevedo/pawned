source 'https://rubygems.org'

# Our framework
gem 'rails', '3.2.2'

group :development, :test do
  gem 'sqlite3'

  # doesn't seem to be working in ruby 1.9.3p0:
  # gem 'ruby-debug19', :require => 'ruby-debug'
end

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

# The all purpose dom manipulation javascript library
gem 'jquery-rails'

# Authentication and authorization, respectively
gem 'devise'
gem 'cancan'

# Simple forms and awesome graphs
gem 'simple_form'
gem 'highcharts-rails'
