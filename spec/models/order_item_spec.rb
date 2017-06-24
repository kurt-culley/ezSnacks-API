require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  # Association
  it { should belong_to(:menu_item) }
  it { should belong_to(:order) }

  # Validation
  it { should validate_presence_of(:menu_item_id) }
end
