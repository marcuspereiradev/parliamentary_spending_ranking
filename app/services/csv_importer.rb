class CsvImporter
  def self.import(params)
    file = params["csv"].tempfile.path

    File.open(file).each do |row|
      begin
        row = row.split(";")

        next if row[0] == "txNomeParlamentar"

        txNomeParlamentar = self.format_to_valid_string(row[0].strip)
        ideCadastro = self.format_to_valid_string(row[2].strip)
        sgUF = self.format_to_valid_string(row[5].strip)
        sgPartido = self.format_to_valid_string(row[6].strip)

        self.create_deputy(ideCadastro, txNomeParlamentar, sgUF, sgPartido) if sgUF == "RJ"

      rescue SystemCallError => e
        puts "Rescued #{e.inspect}"
      end
    end

    File.open(file).each do |row|
      begin
        row = row.split(";")

        next if row[0] == "txNomeParlamentar"

        ideCadastro = self.format_to_valid_string(row[2].strip)
        sgUF = self.format_to_valid_string(row[5].strip)
        vlrLiquido = self.format_to_valid_string(row[19].strip)
        txtFornecedor = self.format_to_valid_string(row[12].strip)
        urlDocumento = self.format_to_valid_string(row[30].strip)
        datEmissao = self.format_to_valid_string(row[16].strip)

        self.create_spent_of_deputy(ideCadastro, vlrLiquido, txtFornecedor, urlDocumento, datEmissao) if sgUF == "RJ"
      rescue SystemCallError => e
        puts "Rescued #{e.inspect}"
      end
    end
  end

  private

  def self.create_deputy(ideCadastro, txNomeParlamentar, sgUF, sgPartido)
    Deputy.find_or_create_by!(
      ideCadastro: ideCadastro,
      txNomeParlamentar: txNomeParlamentar,
      sgUF: sgUF,
      sgPartido: sgPartido,
      avatar: "https://www.camara.leg.br/internet/deputado/bandep/#{ideCadastro}.jpgmaior.jpg",
      avatarCongresso: "https://www.camara.leg.br/internet/deputado/bandep/pagina_do_deputado/#{ideCadastro}.jpg",
    )
  end

  def self.create_spent_of_deputy(ideCadastro, vlrLiquido, txtFornecedor, urlDocumento, datEmissao)
    Spent.create(
      deputy_id: Deputy.find_by(ideCadastro: ideCadastro).id,
      vlrLiquido: vlrLiquido.to_f,
      txtFornecedor: txtFornecedor,
      urlDocumento: urlDocumento,
      datEmissao: datEmissao,
    )
  end

  def self.format_to_valid_string(string)
    string.gsub!(/\A"|"\Z/, '')
  end
end
