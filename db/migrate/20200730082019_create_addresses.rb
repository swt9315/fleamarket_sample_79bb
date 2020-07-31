class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer :post_code,           null: false
      t.string :prefecture_id,        null: false
      t.string :city,                 null: false
      t.string :house_number,         null: false
      t.string :building_name
      t.string :phone_number,         null: false
      t.references :user,             foreign_key: true
      t.timestamps
    end
  end
end
