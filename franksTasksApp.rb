require 'rubygems'
require 'sinatra'


class FranksTaskApp <Sinatra::Base
  #set :run, true
  #set :server, ['webrick']
  set :app_file, __FILE__ # Affects :views, :public and :root
  
  def initialize(*args)
      super
      @title = "Frank's Tasks"
      
      @nav_bar =  <<-EOS
          <ul class="menu">
            <li><a href="/tasks">My Tasks</a></li>
            <li><a href="/newtask">New Task</a></li>
          </ul>
      EOS
  end

  get '/exit' do
    exit
  end

  error do
    e = request.env['sinatra.error']
    "There was an error: #{e}"
  end

  get '/' do
    session["user"] ||= nil
    puts "#{SimpleTask.all.class}"
    erb :franksTasks
  end
  
  get '/mytasks' do
    erb :myTasks
  end
  
  get '/login' do
    erb :login
  end
  
  get '/newtask' do
    erb :newtask
  end
  
  post '/newtask' do
    task = SimpleTask.persistent_new(params)
    ObjectLogEntry.info("A new Task", task).add_to_log
    user = AppUser.validateUser(session["user"].split[0], session["user"].split[1])
    puts "ALL #{task.__id__} #{SimpleTask.all} #{SimpleTask.all.class} #{SimpleTask.all.__id__}"
    user.addTask(task)
    redirect '/mytasks'
  end
  
  get '/task/:id' do
    puts "DOOOING!!!!!"
    puts "ALL #{SimpleTask.all} #{SimpleTask.all.class} #{SimpleTask.all.__id__}"
    SimpleTask.all.each do |task|
      puts task.__id__
    end
    task = SimpleTask.findById(params[:id].to_i)
    puts params[:id]
    puts task
    raise "Page not found (id: #{params[:id]})" unless task
    @task = task
    erb :task
  end
  
  get '/register' do
    erb :register
  end
  
  post '/register' do
    user = AppUser.persistent_new(params)
    ObjectLogEntry.info("A new User", user).add_to_log
    redirect '/login'
  end
  
  post '/login' do
    user = AppUser.validateUser(params[:login], params[:password])
    if !user.nil?
      session["user"] = user.to_s
      redirect '/mytasks'
    else
      raise "Login not successful"
    end
  end  
end
