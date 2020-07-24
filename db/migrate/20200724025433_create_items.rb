class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :category_id, null: false
      t.string :brand
      t.integer :conditon, null: false, default: 0
      t.integer :postage_user, null: false, default: 0
      t.integer :perfecture_id, null: false
      t.integer :preparation_day, null: false, default: 0
      t.integer :price, null: false
      t.timestamps
    end
  end
end
