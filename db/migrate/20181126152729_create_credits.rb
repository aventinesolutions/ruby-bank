class CreateCredits < ActiveRecord::Migration[5.2]
  def change
    create_table :credits do |t|
      t.references :account, null: false
      t.decimal :amount, precision: 12, scale: 2, null: false, default: 0.0
      t.timestamps
      t.foreign_key :accounts
    end
  end
end
