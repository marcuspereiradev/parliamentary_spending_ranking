# frozen_string_literal: true

# Parliamentary
class Parliamentary < ApplicationRecord
  has_many :spents, dependent: :destroy
end
