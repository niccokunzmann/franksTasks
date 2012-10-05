require 'rubygems'
require 'sinatra'

set :run, true
set :server, ['webrick']

get '/' do
    erb :index
end

__END__

@@layout
<!DOCTYPE html>
<html>
  <head>
    <title>Frank's Tasks</title>
    <meta http-equiv="Content-Type" content="text/html;  charset=iso-8859-1" />
  </head>
  <body>
    <h2>Frank's Tasks</h2>
    <%= yield %>
  </body>
</html>


@@index
  <h3>Tasks ToDo:</h3>
  <p>Sinatra <%= Sinatra::VERSION %> says Hello at <%= Time.now %></p>
