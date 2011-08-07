class CreatePanels < ActiveRecord::Migration
  def self.up
    create_table :panels do |t|
      t.string :name
      t.integer :app_id
      t.integer :user_id
      t.text :content
      t.boolean :enabled, :default => true
      t.string :content_url
      t.boolean :use_content_url, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :panels
  end
end
