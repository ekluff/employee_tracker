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
  name = params.fetch('new_name')

  @division = Division.find(id)
  @division.update({name: name})

  # @employees = @division.employees

  redirect to("/divisions/#{id}")

  # erb :division
end

delete('/divisions/:id') do
  id = params.fetch('id').to_i

  division = Division.find(id)
  division.delete # unless Division.all == []

  # @divisions = Division.all

  redirect to('/divisions')
  # erb(:divisions)
end

post '/divisions/new/employee' do
  name = params.fetch('employee_name')
  division_id = params.fetch('division_id').to_i

  employee = Employee.create({name: name, division_id: division_id})

  @division = Division.find(division_id)
  @employees = @division.employees

  erb(:division)
end

delete('/divisions/employees/:id') do
  id = params.fetch('id').to_i

  employee = Employee.find(id)
  employee.delete

  redirect to('/divisions')

end

# employee routes


get('/employees') do
  @employees = Employee.all
  @divisions = Division.all
  erb :employees
end

post('/employees/new') do
  name = params.fetch('name')
  division_id = params.fetch('division_id').to_i

  Employee.create({name: name, division_id: division_id})

  redirect to('/employees')
end

get('/employees/:id') do
  id = params.fetch('id').to_i

  @employee = Employee.find(id)
  @divisions = Division.all
  @division = Division.find(@employee.division_id)

  erb :employee
end

patch('/employees/:id') do
  id = params.fetch('id').to_i
  new_name = params.fetch('new_name')
  new_division_id = params.fetch('new_division_id').to_i

  @employee = Employee.find(id)

  if new_name == ""
    new_name = @employee.name
  end

  @employee.update({name: new_name, division_id: new_division_id})

  # @employees = @employee.employees

  redirect to("/employees/#{id}")

  # erb :employee
end

delete('/employees/:id') do
  id = params.fetch('id').to_i

  employee = Employee.find(id)
  employee.delete # unless Employee.all == []

  # @employees = Employee.all

  redirect to('/employees')
  # erb(:employees)
end
