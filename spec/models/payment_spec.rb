require 'rails_helper'

RSpec.describe Payment, type: :model do

  # Association
  it { should belong_to(:order) }

  # Validation
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:braintree_id) }
end
