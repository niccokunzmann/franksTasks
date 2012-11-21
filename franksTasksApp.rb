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
    puts "ALL 1 #{AppTask.all.class}"
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
  
  get '/register' do
    erb :register
  end
  
  post '/register' do
    user = AppUser.persistent_new(params)
    ObjectLogEntry.info("A new User", user).add_to_log
    puts "ALL USER1 #{user.__id__} #{AppUser.all} #{AppUser.all.class} #{AppUser.all.__id__}"
    redirect '/login'
  end
  
  post '/newtask' do
    Maglev.abort_transaction
    task = AppTask.persistent_new(params)
    Maglev.commit_transaction
    ObjectLogEntry.info("A new Task", task).add_to_log
    puts "ALL TASK1 #{task.__id__} #{AppTask.all} #{AppTask.all.class} #{AppTask.all.__id__}"
    puts "CLASS #{task.__id__.class}"
    user = AppUser.validateUser(session["user"].split[0], session["user"].split[1])
    Maglev.abort_transaction
    user.addTask(task)
    Maglev.commit_transaction
    redirect '/mytasks'
  end
  
  post '/login' do
    user = AppUser.validateUser(params[:login], params[:password])
    puts "ALL USER2 #{user.__id__} #{AppUser.all} #{AppUser.all.class} #{AppUser.all.__id__}"
    if !user.nil?
      session["user"] = user.to_s
      redirect '/mytasks'
    else
      raise "Login not successful"
    end
  end
  
  get '/task/:id' do
    puts "ALL TASK2 #{params[:id]} #{AppTask.all} #{AppTask.all.class} #{AppTask.all.__id__}"
    task = AppTask.findById(params[:id].to_i)
    if task
      @task = task
      erb :task
    else
      raise "Page not found (id: #{params[:id]})"
    end
  end  
end
