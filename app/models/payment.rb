class Payment < ApplicationRecord
  belongs_to :order

  validates_presence_of :braintree_id
end
