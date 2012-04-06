class RemovePersonFromLoans < ActiveRecord::Migration
  def up
    remove_column :loans, :person
      end

  def down
    add_column :loans, :person, :string
  end
end
