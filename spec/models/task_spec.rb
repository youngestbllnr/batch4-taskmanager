require 'rails_helper'

RSpec.describe Task, :type => :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:due_date) }
end