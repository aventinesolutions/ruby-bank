class CreateTransfers < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.integer :from_account_id, null: false
      t.integer :to_account_id, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false, default: 0.0
      t.timestamps
      t.foreign_key :accounts, column: :from_account_id
      t.foreign_key :accounts, column: :to_account_id
    end
  end
end
