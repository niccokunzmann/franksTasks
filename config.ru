# This runs both the blog app and the object log viewer as separate
# Sinatra apps in the same process
#
#\ --port 4444		

require 'sinatra'
require 'franksTasksApp'
require 'txn_wrapper'
require 'maglev_session'

use MagLevTransactionWrapper
use MaglevSession

map "/" do
  run FranksTaskApp
end
