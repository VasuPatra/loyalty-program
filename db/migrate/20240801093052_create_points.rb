class CreatePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :points do |t|
      t.integer :value, default: 0
      t.references :payout, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
