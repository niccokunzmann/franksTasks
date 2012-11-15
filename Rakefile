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
