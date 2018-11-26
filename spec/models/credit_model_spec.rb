require 'rails_helper'

RSpec.describe Credit, type: :model do
  it { is_expected.to have_db_column(:user_id).with_options(type: :bigint, null: false) }
  it { is_expected.to have_db_column(:amount).with_options(type: :decimal, precision: 12, scale: 2, default: 0.0, null: false) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_numericality_of(:amount).is_greater_than(0.0)}

  describe '#amount' do
    let(:password) { Faker::Internet.password }
    let!(:user) do
      User.create!(
        fullname: Faker::Name.name,
        email: Faker::Internet.safe_email,
        password: password,
        password_confirmation: password
      )
    end

    subject { Credit.create!(user: user, amount: 2.0) }

    specify { expect(subject.user.balance).to be == 2.0 }
  end
end