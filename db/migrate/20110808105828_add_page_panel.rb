class AddPagePanel < ActiveRecord::Migration
  def self.up
    add_column :pages, :panel_id, :integer
  end

  def self.down
    remove_column :pages, :panel_id
  end
end
