class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :deputies, :ideCadastro, :ide_cadastro
    rename_column :deputies, :txNomeParlamentar, :tx_nome_parlamentar
    rename_column :deputies, :sgUF, :sg_uf
    rename_column :deputies, :sgPartido, :sg_partido
    rename_column :deputies, :avatarCongresso, :avatar_congresso

    rename_column :spents, :vlrLiquido, :vlr_liquido
    rename_column :spents, :txtFornecedor, :txt_fornecedor
    rename_column :spents, :urlDocumento, :url_documento
    rename_column :spents, :datEmissao, :dat_emissao
  end
end
