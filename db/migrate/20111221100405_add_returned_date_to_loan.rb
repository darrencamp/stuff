class AddReturnedDateToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :returned_date, :datetime
  end
end
