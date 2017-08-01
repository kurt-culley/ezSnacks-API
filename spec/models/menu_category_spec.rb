require 'rails_helper'

RSpec.describe MenuCategory, type: :model do

  # Association
  it { should have_many(:menu_items) }
  it { should belong_to(:restaurant) }

  # Validation
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:image_url) }
end
