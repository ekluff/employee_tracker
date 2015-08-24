require('capybara/rspec')
require('./app')
require('sinatra')
require('spec_helper')


Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the division path') do
  describe('visiting the divisions page', {:type => :feature}) do
    it 'allows you to visit a page that displays all the divisions' do
      division = Division.create({name: 'Tacocat de Gato'})
      visit('/')
      click_link('divisions')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('adding a new division', {:type => :feature}) do
    it 'allows the user to add a new division on the divisions page' do
      visit('/divisions')
      fill_in('name', with: 'Tacocat de Gato')
      click_button('+ division')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('visiting a division page', {:type => :feature}) do
    it 'allows you to view the name and employees of a division' do
      division = Division.create({name: 'Tacocat de Gato'})
      employee = Employee.create({name: 'Tacocat de Perro', division_id: division.id})
      visit('/divisions')
      click_link('Tacocat de Gato')
      expect(page).to have_content('Tacocat de Gato')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('adding a new employee to on the division page', {:type => :feature}) do
    it 'allows you to add a employee to a division from the division page' do
      division = Division.create({name: 'Tacocat de Gato'})
      visit("/divisions/#{division.id}")
      fill_in('employee_name', with: 'Tacocat de Perro')
      click_button('+ employee')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('changing the name of a division', {:type => :feature}) do
    it 'allows you to change the name of a division from the division page' do
      division = Division.create({name: 'Tacocat de Gato'})
      visit("/divisions/#{division.id}")
      fill_in('new_name', with: 'Tacocat de Perro')
      click_button('save')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('clicking the delete button on the division page', {:type => :feature}) do
    it 'allows you to delete a division and delivers you to back to the divisions page' do
      division = Division.create({name: 'Tacocat de Gato'})
      division2 = Division.create({name: 'Tacocat de Perro'})
      division2.save
      visit("/divisions/#{division.id}")
      click_button('delete')
      expect(page).to have_no_content('Tacocat de Gato')
    end
  end
end

describe('the employee path') do
  describe('visiting the employees page', {:type => :feature}) do
    it 'allows a user to visit a page that displays all the employees and their divisions' do
      division = Division.create({name: 'Tacocat de Gato'})
      employee = Employee.create({name: 'Tacocat de Perro', division_id: division.id})
      visit('/employees')
      expect(page).to have_content('Tacocat de Perro')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('filling in employee name and clicking submit on the employees page', {:type => :feature}) do
    it 'allows you to add a new employee' do
      division = Division.create({name: 'Taco Emporium'})
      visit('/employees')
      fill_in('name', with: 'Tacocat de Gato')
      select 'Taco Emporium', from: 'division_id'
      click_button('+ employee')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('visiting a employee page', {:type => :feature}) do
    it 'allows you to click the name of a employee and see their name and divisi' do
      division = Division.create({name: 'Tacocat de Gato'})
      employee = Employee.create({name: 'Tacocat de Perro', division_id: division.id})
      visit('/employees')
      click_link('Tacocat de Gato')
      expect(page).to have_content('Tacocat de Gato')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('changing the name of a employee', {:type => :feature}) do
    it 'allows you to change the name of a employee on the employee page' do
      division = Division.create({name: 'Tacocat de Gato'})
      employee = Employee.create({name: 'Tacocat de Perro', division_id: division.id})
      visit("/employees/#{employee.id}")
      fill_in('new_name', with: 'Tacocat de Perro')
      click_button('save')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('clicking an employee delete button', {:type => :feature}) do
    it 'allows you to delete a employee and delivers you to back to the employees page' do
      division = Division.create({name: 'Tacocat de Gato'})
      employee = Employee.create({name: 'Tacocat de Perro', division_id: division.id})
      visit("/employees/#{employee.id}")
      click_button('delete')
      expect(page).to have_no_content('Tacocat de Perro')
    end
  end
end
