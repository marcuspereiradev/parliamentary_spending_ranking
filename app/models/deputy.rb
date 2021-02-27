class Deputy < ApplicationRecord
  has_many :spents

  validates :ideCadastro, presence: true, uniqueness: true
end
