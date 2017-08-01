class Table < ApplicationRecord
  belongs_to :restaurant
  has_many :orders, dependent: :destroy

  validates_presence_of :status
end
