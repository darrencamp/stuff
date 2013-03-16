class AddUserIdToBorrowers < ActiveRecord::Migration
  def change
    add_column :borrowers, :user_id, :integer
  end
end
