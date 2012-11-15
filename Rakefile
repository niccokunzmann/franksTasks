# We may be running under RVM, so define a way to check
def maglev_using_rvm
  ENV['rvm_path'] != "" && (/^maglev/ =~ ENV['rvm_ruby_string']) == 0
end


task :default => :blog

desc "Commit the base blog code to the repository."
task :commit, :force do |t,args|
  sh %{ maglev-ruby -Ilib lib/commit_code.rb #{args.force} }
end

desc "Run the blog app, committing the blog code if necessary"
task :blog => :commit do
  # rackup can be in different places, need to find the correct one
  rackup_exe = maglev_using_rvm ? \
    "#{ENV['BUNDLE_PATH']}/bin/rackup" : "#{ENV['MAGLEV_HOME']}/bin/rackup"
  if File.exists?("#{rackup_exe}")
    sh %{ #{rackup_exe} config.ru }
  else
    puts "[Error] missing file #{rackup_exe}"
    puts "To fix this, make sure rack is properly installed."
    exit 1
  end
end


#task :default => :run

#desc "Run Frank's Task app."
#task :run do
#  sh 'maglev-ruby franksTasksApp.rb'
#end

desc "Run Frank's Task app with ruby."
task :runr do
  sh 'ruby franksTasksApp.rb'
end

desc "run tests"
task :test do
  sh '/bin/sh test/start-selenium.sh'
  sh 'maglev-ruby test/test_all.rb'
end

desc "run tests under ruby"
task :testr do
  sh '/bin/sh test/start-selenium.sh'
  sh 'ruby test/test_all.rb'
end

desc "install required gems"
task :install do
  sh 'maglev-ruby -S bundle install'
end

