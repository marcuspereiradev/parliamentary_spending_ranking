class Deputy < ApplicationRecord
  has_many :spents

  validates :ide_cadastro, presence: true, uniqueness: true
  validates :tx_nome_parlamentar, presence: true, uniqueness: true
  validates :sg_uf, presence: true
end
