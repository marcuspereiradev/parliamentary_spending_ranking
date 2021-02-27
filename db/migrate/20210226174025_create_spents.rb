class CreateSpents < ActiveRecord::Migration[6.1]
  def change
    create_table :spents do |t|
      t.belongs_to :deputy, null: false, foreign_key: true
      t.float :vlrLiquido
      t.string :txtFornecedor
      t.string :urlDocumento
      t.datetime :datEmissao

      t.timestamps
    end
  end
end
