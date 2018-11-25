require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_db_column(:fullname).with_options(type: :string) }
  it { is_expected.to have_db_column(:email).with_options(type: :string) }
  it { is_expected.to have_db_column(:encrypted_password).with_options(type: :string) }


  it { is_expected.to validate_presence_of :fullname }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it { is_expected.to have_one(:account) }
  it { is_expected.to validate_presence_of :account }
end
