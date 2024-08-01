class CreatePayouts < ActiveRecord::Migration[7.1]
  def change
    create_table :payouts do |t|
      t.decimal :amount
      t.string :currency
      t.boolean :foreign
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
