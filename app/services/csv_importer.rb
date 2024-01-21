# frozen_string_literal: true

require 'csv'

# Import CSV
class CsvImporter
  def self.import(file)
    cleaned_csv = File.read(file).delete('"')
    csv = CSV.parse(cleaned_csv, headers: true, header_converters: ->(f) { f.gsub(/[^0-9A-Za-z]/, '') }, col_sep: ';')

    save_csv_data(csv)
  ensure
    File.delete(file)
  end

  class << self
    def save_csv_data(csv)
      Parliamentary.destroy_all

      csv.each do |row|
        next unless row[5] == 'RJ'

        parliamentary = build_parliamentary(row)
        parliamentary_saved = create_parliamentary(parliamentary)

        spents = build_spent(row)
        parliamentary_saved.spents.create(spents)

        parliamentary_saved.update(total_spents: parliamentary_saved.spents.pluck(:vlr_liquido).sum)
      end
    end

    def build_parliamentary(row)
      {
        tx_nome_parlamentar: row[0],
        ide_cadastro: row[2],
        sg_uf: row[5],
        sg_partido: row[6],
        avatar: "https://www.camara.leg.br/internet/deputado/bandep/#{row[2]}.jpgmaior.jpg",
        avatar_congresso: "https://www.camara.leg.br/internet/deputado/bandep/pagina_do_deputado/#{row[2]}.jpg"
      }
    end

    def build_spent(row)
      {
        dat_emissao: row[10],
        txt_fornecedor: row[12],
        vlr_liquido: row[19],
        url_documento: row[30]
      }
    end

    def create_parliamentary(parliamentary)
      Parliamentary.find_or_create_by(parliamentary)
    end
  end
end
