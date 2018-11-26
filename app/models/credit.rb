class Credit < ApplicationRecord
  belongs_to :user
  validates :user, :amount, presence: true
  validates_numericality_of :amount, greater_than: 0.0

  after_validation :add_to_balance

  def add_to_balance
    return unless user.present?
    user.account.balance = user.account.balance + amount
    user.account.save!
  end
end
