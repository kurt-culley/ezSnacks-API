require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  # Association
  it { should have_many(:tables) }
  it { should have_many(:menu_categories) }
  it { should have_many(:orders).through(:tables) }

  # Validation
  it { should validate_presence_of(:name) }
end
