class CreateParliamentaries < ActiveRecord::Migration[6.1]
  def change
    create_table :parliamentaries do |t|
      t.string :tx_nome_parlamentar
      t.string :ide_cadastro
      t.string :sg_uf
      t.string :sg_partido
      t.string :avatar
      t.string :avatar_congresso

      t.timestamps
    end
  end
end
