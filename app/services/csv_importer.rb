class CsvImporter
  def self.import(params)
    file = params["csv"].tempfile.path

    File.open(file).each do |row|
      begin
        row = row.split(";")

        next if row[0] == "txNomeParlamentar"

        tx_nome_parlamentar = self.format_to_valid_string(row[0].strip)
        ide_cadastro = self.format_to_valid_string(row[2].strip)
        sg_uf = self.format_to_valid_string(row[5].strip)
        sg_partido = self.format_to_valid_string(row[6].strip)

        self.create_deputy(ide_cadastro, tx_nome_parlamentar, sg_uf, sg_partido) if sg_uf == "RJ"

      rescue SystemCallError => e
        puts "Rescued #{e.inspect}"
      end
    end

    File.open(file).each do |row|
      begin
        row = row.split(";")

        next if row[0] == "txNomeParlamentar"

        ide_cadastro = self.format_to_valid_string(row[2].strip)
        sg_uf = self.format_to_valid_string(row[5].strip)
        vlr_liquido = self.format_to_valid_string(row[19].strip)
        txt_fornecedor = self.format_to_valid_string(row[12].strip)
        url_documento = self.format_to_valid_string(row[30].strip)
        dat_emissao = self.format_to_valid_string(row[16].strip)

        self.create_spent_of_deputy(ide_cadastro, vlr_liquido, txt_fornecedor, url_documento, dat_emissao) if sg_uf == "RJ"
      rescue SystemCallError => e
        puts "Rescued #{e.inspect}"
      end
    end
  end

  private

  def self.create_deputy(ide_cadastro, tx_nome_parlamentar, sg_uf, sg_partido)
    Deputy.find_or_create_by!(
      ide_cadastro: ide_cadastro,
      tx_nome_parlamentar: tx_nome_parlamentar,
      sg_uf: sg_uf,
      sg_partido: sg_partido,
      avatar: "https://www.camara.leg.br/internet/deputado/bandep/#{ide_cadastro}.jpgmaior.jpg",
      avatar_congresso: "https://www.camara.leg.br/internet/deputado/bandep/pagina_do_deputado/#{ide_cadastro}.jpg",
    )
  end

  def self.create_spent_of_deputy(ide_cadastro, vlr_liquido, txt_fornecedor, url_documento, dat_emissao)
    Spent.create(
      deputy_id: Deputy.find_by(ide_cadastro: ide_cadastro).id,
      vlr_liquido: vlr_liquido.to_f,
      txt_fornecedor: txt_fornecedor,
      url_documento: url_documento,
      dat_emissao: dat_emissao,
    )
  end

  def self.format_to_valid_string(string)
    string.gsub!(/\A"|"\Z/, '')
  end
end
