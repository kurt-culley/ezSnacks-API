class Payment < ApplicationRecord
  belongs_to :order

  validates_presence_of :status, :braintree_id
end
