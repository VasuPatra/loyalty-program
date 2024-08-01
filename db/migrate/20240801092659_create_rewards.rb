class CreateRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :rewards do |t|
      t.string :name, null: false
      t.text :description
      t.integer :reward_type
      t.text :condition
      t.date :expiry_date

      t.timestamps
    end
  end
end
