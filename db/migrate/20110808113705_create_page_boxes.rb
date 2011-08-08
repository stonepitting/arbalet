class CreatePageBoxes < ActiveRecord::Migration
  def self.up
    create_table :page_boxes do |t|
      t.integer :box_id 
      t.integer :page_id
      t.integer :app_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :page_boxes
  end
end
