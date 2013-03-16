class AddTimestampsToBorrowers < ActiveRecord::Migration
  def change
    add_timestamps :borrowers
  end
end
