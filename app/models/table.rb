class Table < ApplicationRecord
  belongs_to :restaurant

  validates_presence_of :status
end
