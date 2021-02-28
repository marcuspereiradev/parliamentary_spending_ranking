class Deputy < ApplicationRecord
  has_many :spents

  validates :ideCadastro, presence: true, uniqueness: true
  validates :txNomeParlamentar, presence: true, uniqueness: true
  validates :sgUF, presence: true
end
