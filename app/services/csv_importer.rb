require 'csv'
class CsvImporter
  def self.import(file)
    path = file.tempfile.path
    clean_csv = File.read(path).delete('"')
    csv = CSV.parse(clean_csv, headers: true, header_converters: -> (f) {f.gsub(/[^0-9A-Za-z]/, '')}, col_sep: ';')

    csv_hash = []

    csv.each do |row|
      csv_hash << row.to_h
    end

    rj_only = csv_hash.select{ |row| row['sgUF'] == 'RJ' }

    self.create_deputy(rj_only)
    self.create_spent_of_deputy(rj_only)
  end

  private

  def self.create_deputy(data)
    deputy_data = data.map do |hash|
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
    Deputy.insert_all(deputy_data)
  end

  def self.create_spent_of_deputy(data)
    deputy_data = data.map do |hash|
      hash["vlr_liquido"] = hash.delete("vlrLiquido")
      hash["txt_fornecedor"] = hash.delete("txtFornecedor")
      hash["url_documento"] = hash.delete("urlDocumento")
      hash["dat_emissao"] = hash.delete("datEmissao")

      hashes_from_outside_the_csv = {
        "deputy_id" => Deputy.find_by(ide_cadastro: hash["ide_cadastro"]).id,
        "created_at" => Time.current,
        "updated_at" => Time.current
      }

      hash.slice("vlr_liquido", "txt_fornecedor", "url_documento", "dat_emissao")
          .merge(hashes_from_outside_the_csv)
    end
    Spent.insert_all(deputy_data)
  end
end
