class ChangeDatatypeOfItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :seller_id, :bigint
  end
end
