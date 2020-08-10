class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.references :user,    null: false, foreign_key: true
      t.string :customer_id, null: false # payjpの顧客id
      t.string :card_id,     null: false # payjpのデフォルトカードid

      t.timestamps
    end
  end
end
