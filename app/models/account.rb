class Account < ApplicationRecord
  belongs_to :user
  validates :user, :balance, presence: true
  has_many :credits, dependent: :destroy
  has_many :transfers_from, class_name: 'Transfer', foreign_key: :from_account_id
  has_many :transfers_to, class_name: 'Transfer', foreign_key: :to_account_id

  def all_transactions
    (all_credits + all_debits).sort { |l, r| r[:created_at] <=> l[:created_at] }
  end

  def all_credits
    (credits + transfers_to).map(&method(:transaction_attributes))
  end

  def all_debits
    transfers_from.map { |transaction| transaction_attributes(transaction, :debit) }
  end

  private

  def transaction_attributes(transaction, type = :credit)
    { transaction_type: type, created_at: transaction.created_at, amount: transaction.amount }.tap do |attributes|
      attributes[:to_email] = transaction.to_account.user.email if type == :debit
      attributes[:from_email] = transaction.from_account.user.email if type == :credit && transaction.kind_of?(Transfer)
    end
  end
end
