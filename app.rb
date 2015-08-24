require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/division')
require('./lib/employee')
also_reload('lib/**/*.rb')

get('/') do
  erb :index
end

# division routes

get('/divisions') do
  @divisions = Division.all

  erb :divisions
end

post('/divisions/new') do
  name = params.fetch('name')

  Division.create({name: name})

  @divisions = Division.all

  erb :divisions
end

get('/divisions/:id') do
  id = params.fetch('id').to_i

  @division = Division.find(id)
  @employees = @division.employees

  erb :division
end

patch('/divisions/:id') do
  id = params.fetch('id').to_i
  name = params.fetch('name')

  @division = Division.find(id)
  @division.update({name: name})

  # @employees = @division.employees

  redirect_to("/divisions/#{id}")

  # erb :division
end

delete('/divisions/:id') do
  id = params.fetch('id').to_i

  division = Division.find(id)
  division.delete # unless Division.all == []

  # @divisions = Division.all

  redirect_to('/divisions')
  # erb(:divisions)
end

# employee routes


get('/employees') do
  @employees = Employee.all
  @divisions = Division.all
  erb :employees
end

post('/employees/new') do
  name = params.fetch('name')

  Employee.create({name: name})

  redirect_to('/employees')
end

get('/employees/:id') do
  id = params.fetch('id').to_i

  @employee = Employee.find(id)
  @divisions = Division.all

  erb :employee
end

patch('/employees/:id') do
  id = params.fetch('id').to_i
  name = params.fetch('name')

  @employee = Employee.find(id)
  @employee.update({name: name})

  # @employees = @employee.employees

  redirect_to("/employees/#{id}")

  # erb :employee
end

delete('/employees/:id') do
  id = params.fetch('id').to_i

  employee = Employee.find(id)
  employee.delete # unless Employee.all == []

  # @employees = Employee.all

  redirect_to('/employees')
  # erb(:employees)
end
