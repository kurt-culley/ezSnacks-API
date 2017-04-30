require 'rails_helper'

RSpec.describe MenuItem, type: :model do

  # Association
  it { should belong_to(:menu_category) }

  # Validation
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:image_url) }
  it { should validate_presence_of(:menu_category) }
end
