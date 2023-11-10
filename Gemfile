source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
gem 'mysql2', '>= 0.4.4'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.2', require: false
# Manage environment setting
gem 'config'
# Authentication
gem 'devise'
# Save session in database
gem 'activerecord-session_store'
# Json Web Token supports authenticate api
gem 'jwt'
# Admin rails engine
gem 'activeadmin'
# Rick text in active_admin
gem 'ckeditor'
# Style image, get metadata of file
gem "mini_magick"
# Transform image to many verions
gem 'image_processing'
# Upload file upto aws S3
gem 'aws-sdk-s3'
# Add validate when update file with active_storage
gem 'active_storage_validations'
# pagination
gem 'kaminari'
gem 'ed25519'
gem 'bcrypt_pbkdf'
# support for format JSON
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  # debug
  gem 'pry-rails'
end

group :development do
  # Deployment
  gem 'capistrano',         require: false
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
