class Transfer < ApplicationRecord
  belongs_to :from_account, class_name: 'Account', foreign_key: :from_account_id, dependent: :destroy
  belongs_to :to_account, class_name: 'Account', foreign_key: :to_account_id, dependent: :destroy
  validates :from_account, :to_account, :amount, presence: true
  validates_numericality_of :amount, greater_than: 0.0
  validates_with TransferAccountsUnequalValidator


  after_validation :adjust_balances

  def adjust_balances
    return unless from_account.present? && to_account.present?
    from_account.balance = from_account.balance - amount
    fail 'cannot transfer, balance insufficient' if from_account.balance < 0.0
    to_account.balance = to_account.balance + amount
  end
end
