class ChangeLoansToUseItems < ActiveRecord::Migration
  def up
    add_column :loans, :item_id, :integer
    remove_column :loans, :item
  end

  def down
    add_column :loans, :item, :string
    remove_column :loans, :item_id
  end
end
