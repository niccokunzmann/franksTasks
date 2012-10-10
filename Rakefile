task :default => :run

desc "Run Frank's Task app."
task :run do
  sh 'maglev-ruby franksTasksApp.rb'
end

desc "Run Frank's Task app with ruby."
task :runr do
  sh 'ruby franksTasksApp.rb'
end

desc "run tests"
task :test do
  sh '/bin/sh test/start-selenium.sh'
  sh 'maglev-ruby test/test_all.rb'
end

desk "run tests under ruby"
task :testr do
  sh '/bin/sh test/start-selenium.sh'
  sh 'ruby test/test_all.rb'
end

desc "install required gems"
task :install do
  sh 'maglev-ruby -S bundle install'
end
