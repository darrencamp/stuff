class RemoveBorrowerEmailFromLoans < ActiveRecord::Migration
  def up
    remove_column :loans, :borrower_email
  end

  def down
    add_column :loans, :borrower_email, :string
  end
end
