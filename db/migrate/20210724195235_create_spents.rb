class CreateSpents < ActiveRecord::Migration[6.1]
  def change
    create_table :spents do |t|
      t.string :tx_nome_parlamentar
      t.string :cpf
      t.string :ide_cadastro
      t.string :numero_carteira_parlamentar
      t.string :number_legislatura
      t.string :sg_uf
      t.string :sg_partido
      t.string :cod_legislatura
      t.string :numero_sub_cota
      t.string :txt_descricao
      t.string :numero_especificacao_subcota
      t.string :txt_descricao_especificacao
      t.string :txt_fornecedor
      t.string :txt_cnpj_cpf
      t.string :txt_numero
      t.string :ind_tipo_documento
      t.datetime :dat_emissao
      t.float :vlr_documento
      t.float :vlr_glosa
      t.float :vlr_liquido
      t.string :num_mes
      t.string :num_ano
      t.string :num_parcela
      t.string :txt_passageiro
      t.string :txt_trecho
      t.string :num_lote
      t.string :num_ressarcimento
      t.string :vlr_restituicao
      t.string :nu_deputado_id
      t.string :ide_documento
      t.string :url_documento

      t.timestamps
    end
  end
end
