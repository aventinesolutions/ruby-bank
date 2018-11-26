class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :account, dependent: :destroy
  delegate :balance, to: :account

  validates :fullname, presence: true

  before_validation :ensure_account_exists

  def ensure_account_exists
    self.account = Account.create unless account.present?
  end
end
