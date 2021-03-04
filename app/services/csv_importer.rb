require 'csv'
class CsvImporter
  def self.import(file)
    path = file.tempfile.path
    clean_csv = File.read(path).delete('"')
    csv = CSV.parse(clean_csv, headers: true, header_converters: -> (f) {f.gsub(/[^0-9A-Za-z]/, '')}, col_sep: ';')

    csv_hash = []

    csv.each do |row|
      csv_hash << row.to_h#.slice("txNomeParlamentar", "ideCadastro", "sgUF", "sgPartido")
    end

    rj_only = csv_hash.select{ |row| row['sgUF'] == 'RJ' }

    self.create_deputy(rj_only)

    # {"﻿txNomeParlamentar"=>"Marcão Gomes", "cpf"=>"09300885731", "ideCadastro"=>"212749", "nuCarteiraParlamentar"=>"551", "nuLegislatura"=>"2019", "sgUF"=>"RJ", "sgPartido"=>"PL", "codLegislatura"=>"56", "numSubCota"=>"122", "txtDescricao"=>"SERVIÇO DE TÁXI, PEDÁGIO E ESTACIONAMENTO", "numEspecificacaoSubCota"=>"0", "txtDescricaoEspecificacao"=>nil, "txtFornecedor"=>"AEROSDUMONT COOPERATIVA DOS MOTORISTAS DE TAXI COMUM DO AEROPORTO SANTOS DUMONT LTDA", "txtCNPJCPF"=>"012.987.720/0011-4", "txtNumero"=>"s/n", "indTipoDocumento"=>"1", "datEmissao"=>"2020-03-05T00:00:00", "vlrDocumento"=>"35", "vlrGlosa"=>"0", "vlrLiquido"=>"35", "numMes"=>"3", "numAno"=>"2020", "numParcela"=>"0", "txtPassageiro"=>nil, "txtTrecho"=>nil, "numLote"=>"1686655", "numRessarcimento"=>nil, "vlrRestituicao"=>nil, "nuDeputadoId"=>"3465", "ideDocumento"=>"7037226", "urlDocumento"=>"https://www.camara.leg.br/cota-parlamentar/documentos/publ/3465/2020/7037226.pdf"}

    # File.open(file).each do |row|
    #   begin
    #     row = row.split(";")

    #     next if row[0] == "txNomeParlamentar"

    #     tx_nome_parlamentar = self.format_to_valid_string(row[0].strip)
    #     ide_cadastro = self.format_to_valid_string(row[2].strip)
    #     sg_uf = self.format_to_valid_string(row[5].strip)
    #     sg_partido = self.format_to_valid_string(row[6].strip)

    #     self.create_deputy(ide_cadastro, tx_nome_parlamentar, sg_uf, sg_partido) if sg_uf == "RJ"

    #   rescue SystemCallError => e
    #     puts "Rescued #{e.inspect}"
    #   end
    # end

    # File.open(file).each do |row|
    #   begin
    #     row = row.split(";")

    #     next if row[0] == "txNomeParlamentar"

    #     ide_cadastro = self.format_to_valid_string(row[2].strip)
    #     sg_uf = self.format_to_valid_string(row[5].strip)
    #     vlr_liquido = self.format_to_valid_string(row[19].strip)
    #     txt_fornecedor = self.format_to_valid_string(row[12].strip)
    #     url_documento = self.format_to_valid_string(row[30].strip)
    #     dat_emissao = self.format_to_valid_string(row[16].strip)

    #     self.create_spent_of_deputy(ide_cadastro, vlr_liquido, txt_fornecedor, url_documento, dat_emissao) if sg_uf == "RJ"
    #   rescue SystemCallError => e
    #     puts "Rescued #{e.inspect}"
    #   end
    # end
  end

  private

  def self.create_deputy(data)
    deputy_data = data.map do |hash|
      hash["tx_nome_parlamentar"] = hash.delete("txNomeParlamentar")
      hash["tx_nome_parlamentar"] = hash.delete("txNomeParlamentar")
      hash["ide_cadastro"] = hash.delete("ideCadastro")
      hash["sg_uf"] = hash.delete("sgUF")
      hash["sg_partido"] = hash.delete("sgPartido")

      hashes_from_outside_the_csv = {
        "avatar" => "https://www.camara.leg.br/internet/deputado/bandep/#{hash["ide_cadastro"]}.jpgmaior.jpg",
        "avatar_congresso" => "https://www.camara.leg.br/internet/deputado/bandep/pagina_do_deputado/#{hash["ide_cadastro"]}.jpg",
        "created_at" => Time.current,
        "updated_at" => Time.current
      }

      hash.slice("tx_nome_parlamentar", "ide_cadastro", "sg_uf", "sg_partido")
          .merge(hashes_from_outside_the_csv)
    end
    puts deputy_data.class

    Deputy.insert_all(deputy_data)
  end

  # def self.create_spent_of_deputy(ide_cadastro, vlr_liquido, txt_fornecedor, url_documento, dat_emissao)
  #   Spent.create(
  #     deputy_id: Deputy.find_by(ide_cadastro: ide_cadastro).id,
  #     vlr_liquido: vlr_liquido.to_f,
  #     txt_fornecedor: txt_fornecedor,
  #     url_documento: url_documento,
  #     dat_emissao: dat_emissao,
  #   )
  # end

  # def self.format_to_valid_string(string)
  #   string.gsub!(/\A"|"\Z/, '')
  # end
end
