class CreateDeputies < ActiveRecord::Migration[6.1]
  def change
    create_table :deputies do |t|
      t.string :ideCadastro
      t.string :txNomeParlamentar
      t.string :sgUF
      t.string :sgPartido
      t.string :avatar
      t.string :avatarCongresso

      t.timestamps

      t.index [:ideCadastro, :txNomeParlamentar], unique: true
    end
  end
end
