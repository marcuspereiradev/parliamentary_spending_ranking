class Spent < ApplicationRecord
  belongs_to :deputy

  validates :vlr_liquido, presence: true
end
