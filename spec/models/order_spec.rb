require 'rails_helper'

RSpec.describe Order, type: :model do

  # Association
  it { should belong_to(:restaurant) }

  # Validation
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:table_id) }
end
