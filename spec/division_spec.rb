require 'spec_helper'

describe(Division) do
  describe('.employees') do
    it('tells you which employees work there') do
      division = Division.create({name: 'Taco Factory'})
      employee1 = Employee.create({name: 'Dick Richards', division_id: division.id})
      employee2 = Employee.create({name: 'Tommy Thompson', division_id: division.id})
      expect(division.employees).to(eq([employee1, employee2]))
    end
  end
end
