source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'puma', group: :development

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'capistrano', '~> 3.4.0'
gem 'capistrano-rails'
gem 'capistrano-rvm'
gem 'capistrano-passenger'

group :assets do
  gem 'therubyracer', platforms: :ruby
  gem 'sass-rails', '~> 5.0'
  gem 'coffee-rails', '~> 4.1.0'
  gem 'uglifier', '>= 1.3.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.3.6'
  gem 'quiet_assets'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-flat-ui'
end

gem 'devise'
gem 'cancancan'
gem 'sidekiq'
gem 'searchkick'
gem 'nokogiri'
gem 'metainspector'
gem 'whenever'
gem 'kaminari'
gem 'elasticsearch', git: 'git://github.com/elasticsearch/elasticsearch-ruby.git'
gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'mongoid', '~> 4', github: 'mongoid/mongoid'
gem 'bson_ext'
gem 'mongoid-slug'
gem "paperclip", "~> 4.2"
gem "mongoid-paperclip", :require => "mongoid_paperclip"
gem "aws-s3", :require => "aws/s3"
gem 'aws-sdk', '~> 1.3.4'
gem 'metamagic'
gem 'sitemap_generator'