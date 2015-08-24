require('sinatra')
require('sinatra-activerecord')
require('./lib/division')
require('./lib/employee')
also_reload('./lib/**/*.rb')

get('/') do
  erb :index
end
