require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:fullname).with_options(type: :string) }
  it { is_expected.to have_db_column(:email).with_options(type: :string) }
  it { is_expected.to have_db_column(:encrypted_password).with_options(type: :string) }


  it { is_expected.to validate_presence_of :fullname }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it { is_expected.to have_one(:account).dependent(:destroy) }

  describe '#account' do
    let(:password) { Faker::Internet.password }
    subject do
      User.create!(
        fullname: Faker::Name.name,
        email: Faker::Internet.safe_email,
        password: password,
        password_confirmation: password
      )
    end

    specify { expect(subject.account).to be_a(Account) }
    specify { expect(subject.balance).to be == 0.0 }
    specify { expect(subject.account.balance).to be == subject.balance }
  end
end
