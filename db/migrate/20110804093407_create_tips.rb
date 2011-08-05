class CreateTips < ActiveRecord::Migration
  def self.up
    create_table :tips do |t|
      t.string :content
      t.integer :app_id
      t.integer :user_id
      t.boolean :enabled, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tips
  end
end
