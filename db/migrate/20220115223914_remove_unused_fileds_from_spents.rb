class RemoveUnusedFiledsFromSpents < ActiveRecord::Migration[6.1]
  def change
    remove_column :spents, :tx_nome_parlamentar, :string
    remove_column :spents, :cpf, :string
    remove_column :spents, :ide_cadastro, :string
    remove_column :spents, :numero_carteira_parlamentar, :string
    remove_column :spents, :number_legislatura, :string
    remove_column :spents, :sg_uf, :string
    remove_column :spents, :sg_partido, :string
    remove_column :spents, :cod_legislatura, :string
    remove_column :spents, :numero_sub_cota, :string
    remove_column :spents, :txt_descricao, :string
    remove_column :spents, :numero_especificacao_subcota, :string
    remove_column :spents, :txt_descricao_especificacao, :string
    remove_column :spents, :txt_cnpj_cpf, :string
    remove_column :spents, :txt_numero, :string
    remove_column :spents, :ind_tipo_documento, :string
    remove_column :spents, :vlr_documento, :string
    remove_column :spents, :vlr_glosa, :string
    remove_column :spents, :num_mes, :string
    remove_column :spents, :num_ano, :string
    remove_column :spents, :num_parcela, :string
    remove_column :spents, :txt_passageiro, :string
    remove_column :spents, :txt_trecho, :string
    remove_column :spents, :num_lote, :string
    remove_column :spents, :num_ressarcimento, :string
    remove_column :spents, :vlr_restituicao, :string
    remove_column :spents, :nu_deputado_id, :string
    remove_column :spents, :ide_documento, :string
  end
end
