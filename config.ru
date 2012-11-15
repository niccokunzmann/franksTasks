# This runs both the blog app and the object log viewer as separate
# Sinatra apps in the same process
#
#\ --port 4444 --host localhost

require 'sinatra'
require 'franksTasksApp'
require 'txn_wrapper'

use MagLevTransactionWrapper

map "/" do
  run FranksTaskApp
end
