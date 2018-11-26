require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { is_expected.to have_db_column(:from_account_id).with_options(type: :bigint, null: false) }
  it { is_expected.to have_db_column(:to_account_id).with_options(type: :bigint, null: false) }
  it { is_expected.to have_db_column(:amount).with_options(type: :decimal, precision: 12, scale: 2, default: 0.0, null: false) }

  it { is_expected.to belong_to(:from_account) }
  it { is_expected.to belong_to(:to_account) }

  it { is_expected.to validate_presence_of(:from_account) }
  it { is_expected.to validate_presence_of(:to_account) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0)}

  describe TransferAccountsUnequalValidator do
    let(:password) { Faker::Internet.password }
    let!(:user) do
      User.create!(
        fullname: Faker::Name.name,
        email: Faker::Internet.safe_email,
        password: password,
        password_confirmation: password
      )
    end
    let!(:credit) {
      Credit.create!(account: user.account, amount: 100.0)
    }

    subject { Transfer.create(from_account: user.account, to_account: user.account, amount: 2.0) }

    specify { expect(subject.valid?).to be_falsey }
  end
end