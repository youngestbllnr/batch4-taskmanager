require 'rails_helper'

RSpec.describe User, :type => :model do
  it { is_expected.to have_many(:categories).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }
end