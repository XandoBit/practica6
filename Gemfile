source 'http://rubygems.org'
gem 'sinatra'
gem 'thin'
gem 'json'
gem 'data_mapper'
gem 'sinatra-contrib'





group :development, :test do
	gem 'sqlite3'
	gem "dm-sqlite-adapter"
	gem 'coveralls',require:false
	gem 'selenium-webdriver','2.43.0'
end

group :production do
    gem "pg"
    gem "dm-postgres-adapter"
end
