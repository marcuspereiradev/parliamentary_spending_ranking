# frozen_string_literal: true
require 'csv'

# Import CSV
class CsvImporter
  def self.import(file)
    cleaned_csv = File.read(file).delete('"')
    csv = CSV.parse(cleaned_csv, headers: true, header_converters: ->(f) { f.gsub(/[^0-9A-Za-z]/, '') }, col_sep: ';')

    csv.each do |row|
      next unless row[5] == 'RJ'

      parliamentary = parliamentarians_fields
      spents = spents_fields

      parliamentary[:tx_nome_parlamentar] = row[0]
      parliamentary[:ide_cadastro] = row[2]
      parliamentary[:sg_uf] = row[5]
      parliamentary[:sg_partido] = row[6]
      parliamentary[:avatar] = "https://www.camara.leg.br/internet/deputado/bandep/#{row[2]}.jpgmaior.jpg"
      parliamentary[:avatar_congresso] = "https://www.camara.leg.br/internet/deputado/bandep/pagina_do_deputado/#{row[2]}.jpg"

      spents[:dat_emissao] = row[10]
      spents[:txt_fornecedor] = row[12]
      spents[:vlr_liquido] = row[19]
      spents[:url_documento] = row[30]

      parliamentary_saved = create_deputy(parliamentary)
      create_spents(parliamentary_saved, spents)
    end
  ensure
    File.delete(file)
  end

  class << self
    def parliamentarians_fields
      {
        tx_nome_parlamentar: '',
        ide_cadastro: '',
        sg_uf: '',
        sg_partido: '',
        avatar: '',
        avatar_congresso: ''
      }
    end

    def spents_fields
      {
        vlr_liquido: '',
        txt_fornecedor: '',
        url_documento: '',
        dat_emissao: ''
      }
    end

    def create_deputy(parliamentary)
      Parliamentary.find_or_create_by(parliamentary)
    end

    def create_spents(parliamentary_saved, spents)
      spent = parliamentary_saved.spents.find_or_initialize_by(spents)
      spent.save
    end
  end
end
