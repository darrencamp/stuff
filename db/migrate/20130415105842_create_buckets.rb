class CreateBuckets < ActiveRecord::Migration
  def up
    create_table :buckets do |t|
      t.string :name
      t.string :description
      t.references :user
    end

    add_column :items, :bucket_id, :integer, :null => true
  end

  def down
    remove_column :items, :bucket_id
    drop_table :buckets
  end
end
