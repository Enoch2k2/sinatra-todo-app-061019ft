require './config/environment'

use Rack::MethodOverride
use SessionsController
use TodosController
run ApplicationController
