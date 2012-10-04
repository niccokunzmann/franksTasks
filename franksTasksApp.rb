require 'rubygems'
require 'sinatra'

set :run, true
set :server, ['webrick']

get '/' do
    erb :index
end

__END__

@@layout
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <title>Franks Tasks</title>
    <meta http-equiv="Content-Type" content="text/html;  charset=iso-8859-1" />
  </head>
  <body>
    <h2>Franks Tasks</h2>
    <%= yield %>
  </body>
</html>


@@index
  <h3>Tasks ToDo:</h3>
  <p>Sinatra <%= Sinatra::VERSION %> says Hello at <%= Time.now %></p>