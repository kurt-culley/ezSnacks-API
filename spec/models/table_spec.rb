require 'rails_helper'

RSpec.describe Table, type: :model do

  # Association
  it { should belong_to(:restaurant) }

  # Validation
  it { should validate_presence_of(:status) }
end
