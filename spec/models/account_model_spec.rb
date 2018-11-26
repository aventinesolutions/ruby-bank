require 'rails_helper'

RSpec.describe Account, type: :model do
  it { is_expected.to have_db_column(:user_id).with_options(type: :bigint, null: false) }
  it { is_expected.to have_db_column(:balance).with_options(type: :decimal, precision: 12, scale: 2, default: 0.0, null: false) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:balance) }
end