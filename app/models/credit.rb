class Credit < ApplicationRecord
  belongs_to :account
  validates :account, :amount, presence: true
  validates_numericality_of :amount, greater_than: 0.0

  after_validation :add_to_balance

  def add_to_balance
    return unless account.present?
    account.balance = account.balance + amount
    account.save!
  end
end
