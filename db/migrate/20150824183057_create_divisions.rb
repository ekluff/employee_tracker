class CreateDivisions < ActiveRecord::Migration
  def change
    create_table(:divisions) do |t|
      t.column(:name, :varchar)
      t.timestamps
    end
  end
end
