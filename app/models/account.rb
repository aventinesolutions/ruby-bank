class Account < ApplicationRecord
  belongs_to :user
  validates :user, :balance, presence: true
  has_many :credits, dependent: :destroy
end
