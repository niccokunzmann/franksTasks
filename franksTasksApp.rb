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

    error do
      e = request.env['sinatra.error']
      "There was an error: #{e}"
    end

    get '/' do
      erb :franksTasks
    end
end

__END__

