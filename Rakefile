task :default => :server

desc "run the chat server"
task :server do
  sh "bundle exec ruby chat.rb"
end

desc "make a non Ajax request via curl"
task :noajax do
  sh "curl -v http://localhost:4567/update"
end

desc "make an Ajax request via curl"
task :ajax do
  sh %q{curl -v -H "X-Requested-With: XMLHttpRequest" localhost:4567/update}
end

desc "Visit the GitHub repo page"
task :open do
  sh "open https://github.com/crguezl/chat-blazee"
end

desc "run selenium-capybara examples"
task :test do
  sh "bundle exec rspec -I. test/test.rb"
end

desc "spec"
task :spec do
  sh "bundle exec rspec -I. spec/spec.rb"
end

desc "Run server"
    task :server do
      sh "rackup"
end