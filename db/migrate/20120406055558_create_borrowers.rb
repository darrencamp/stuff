class CreateBorrowers < ActiveRecord::Migration
  def up
    create_table :borrowers do |t|
      t.string :email
      t.string :name
    end
  end

  def down
    drop_table :borrowers
  end
end
