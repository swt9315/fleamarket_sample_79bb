class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name,             null: false
      t.text :introduction,       null: false
      t.string :brand
      t.integer :condition,       null: false, default:0
      t.integer :postage_user,    null: false, default:0
      t.integer :prefecture_id,   null: false
      t.integer :preparation,     null: false
      t.integer :price,           null: false
      t.references :seller,       foreign_key:  { to_table: :users }
      t.references :buyer,        foreign_key:  { to_table: :users }
      t.datetime :closed_at
      
      t.timestamps
    end
  end
end


