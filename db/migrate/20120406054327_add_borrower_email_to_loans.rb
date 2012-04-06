class AddBorrowerEmailToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :borrower_email, :string
    
  end
end
