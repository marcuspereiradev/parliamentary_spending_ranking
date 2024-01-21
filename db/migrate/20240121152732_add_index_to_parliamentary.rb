class AddIndexToParliamentary < ActiveRecord::Migration[6.1]
  def change
    add_index :parliamentaries, :tx_nome_parlamentar
  end
end
