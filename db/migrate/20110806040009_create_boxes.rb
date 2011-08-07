class CreateBoxes < ActiveRecord::Migration
  def self.up
    create_table :boxes do |t|
      t.string :name
      t.integer :app_id
      t.integer :user_id
      t.text :content
      t.boolean :enabled, :default => true
      t.string :target_id

      t.timestamps
    end
  end

  def self.down
    drop_table :boxes
  end
end
