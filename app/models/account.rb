class Account < ApplicationRecord
  belongs_to :user
  validates :user, :balance, presence: true
end