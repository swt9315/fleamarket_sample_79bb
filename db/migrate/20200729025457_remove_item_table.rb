class RemoveItemTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :items
  end
end
