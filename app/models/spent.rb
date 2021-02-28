class Spent < ApplicationRecord
  belongs_to :deputy

  validates :vlrLiquido, presence: true
end
