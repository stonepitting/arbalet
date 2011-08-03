class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.string :url
      t.integer :user_id
      t.integer :app_id
      t.boolean :enabled, :defauls => true

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
