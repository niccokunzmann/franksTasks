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
            <li><a href="/mytasks">My Tasks</a></li>
            <li><a href="/task/new">New Task</a></li>
            <li><a href="/logout">Logout</a></li>
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
    erb :franksTasks
  end
  
  get '/mytasks' do
    erb :myTasks
  end
  
  get '/login' do
    erb :login
  end
  
  get '/task/new' do
    erb :newtask
  end
  
  get '/register' do
    erb :register
  end
  
  get '/logout' do
    session["user"] = nil
    redirect '/login'
  end
  
  post '/register' do
    user = AppUser.persistent_new(params)
    ObjectLogEntry.info("A new User", user).add_to_log
    redirect '/login'
  end
  
  post '/task/new' do
    Maglev.abort_transaction
    task = AppTask.persistent_new(params)
    Maglev.commit_transaction
    ObjectLogEntry.info("A new Task", task).add_to_log
    user = AppUser.validateUser(session["user"].split[0], session["user"].split[1])
    Maglev.abort_transaction
    user.addTask(task)
    Maglev.commit_transaction
    redirect '/mytasks'
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
  
  post '/task/:id/completion' do
    task = AppTask.get(params[:id])
    Maglev.abort_transaction
    (params[:isCompleted] != 0) ? task.done : task.not_done
    Maglev.commit_transaction
    redirect "task/#{params[:id]}"
  end
    
  
  get '/task/:id' do
    task = AppTask.get(params[:id])
    if task
      @task = task
      erb :task
    else
      raise "Page not found (id: #{params[:id]})"
    end
  end  
end
