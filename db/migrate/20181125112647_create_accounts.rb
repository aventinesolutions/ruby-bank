class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, null: false
      t.decimal :balance, precision: 12, scale: 2, null: false, default: 0.0
      t.foreign_key :users
    end
  end
end
