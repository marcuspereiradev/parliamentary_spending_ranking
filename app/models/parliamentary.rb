class Parliamentary < ApplicationRecord
  has_many :spents, dependent: :destroy
end
