require 'rails_helper'

RSpec.describe Order, type: :model do

  # Association
  it { should belong_to(:table) }
  it { should have_many(:order_items) }
  it { should have_many(:menu_items).through(:order_items) }
  it { should have_one(:payment) }

  # Validation
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:table_id) }
end
