require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to have_db_column(:user_id).with_options(type: :bigint, null: false) }
  it { is_expected.to have_db_column(:balance).with_options(type: :decimal, precision: 12, scale: 2, default: 0.0, null: false) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:balance) }

  describe '#all_transactions' do
    let(:password) { Faker::Internet.password }
    let!(:users) do
      [
        User.create!(
          fullname: Faker::Name.name,
          email: Faker::Internet.safe_email,
          password: password,
          password_confirmation: password
        ),
        User.create!(
          fullname: Faker::Name.name,
          email: Faker::Internet.safe_email,
          password: password,
          password_confirmation: password
        ),
      ]
    end
    let!(:transfers) do
      [
        Credit.create!(account: users.first.account, amount: 200.0),
        Credit.create!(account: users.last.account, amount: 200.0),
        Transfer.create!(from_account: users.first.account, to_account: users.last.account, amount: 1.99),
        Transfer.create!(from_account: users.last.account, to_account: users.first.account, amount: 2.99)
      ]
    end

    subject { users.first.account.all_transactions }

    specify { expect(subject.size).to be == 3 }
    specify { expect(subject.select { |t| t[:transaction_type] == :debit }.first[:amount]).to eql(1.99) }
    specify { expect(subject.select { |t| t[:transaction_type] == :credit }.size).to be == 2 }
  end
end