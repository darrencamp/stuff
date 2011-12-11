class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :person
      t.string :contact
      t.string :item

      t.timestamps
    end
  end
end
