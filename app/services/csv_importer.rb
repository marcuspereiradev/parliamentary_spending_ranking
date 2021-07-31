# frozen_string_literal: true
require 'csv'

# Import CSV
class CsvImporter
  def self.import(file)
    cleaned_csv = File.read(file).delete('"')
    csv = CSV.parse(cleaned_csv, headers: true, header_converters: ->(f) { f.gsub(/[^0-9A-Za-z]/, '') }, col_sep: ';')

    all_rj_data = csv.select { |row| row[5] == 'RJ' }

    parliamentarians = all_rj_data.map do |row|
      {
        'tx_nome_parlamentar' => row[0],
        'cpf' => row[1],
        'ide_cadastro' => row[2],
        'numero_carteira_parlamentar' => row[3],
        'number_legislatura' => row[4],
        'sg_uf' => row[5],
        'sg_partido' => row[6],
        'cod_legislatura' => row[7],
        'numero_sub_cota' => row[8],
        'txt_descricao' => row[9],
        'numero_especificacao_subcota' => row[10],
        'txt_descricao_especificacao' => row[11],
        'txt_fornecedor' => row[12],
        'txt_cnpj_cpf' => row[13],
        'txt_numero' => row[14],
        'ind_tipo_documento' => row[15],
        'dat_emissao' => row[16],
        'vlr_documento' => row[17],
        'vlr_glosa' => row[18],
        'vlr_liquido' => row[19],
        'num_mes' => row[20],
        'num_ano' => row[21],
        'num_parcela' => row[22],
        'txt_passageiro' => row[23],
        'txt_trecho' => row[24],
        'num_lote' => row[25],
        'num_ressarcimento' => row[26],
        'vlr_restituicao' => row[27],
        'nu_deputado_id' => row[28],
        'ide_documento' => row[29],
        'url_documento' => row[30],
        'avatar' => "https://www.camara.leg.br/internet/deputado/bandep/#{row[2]}.jpgmaior.jpg",
        'avatar_congresso' => "https://www.camara.leg.br/internet/deputado/bandep/pagina_do_deputado/#{row[2]}.jpg"
      }
    end

    create_deputy(parliamentarians)

    create_spents(parliamentarians)

    File.delete(file)
  end

  class << self
    def create_deputy(parliamentarians)
      parliamentarians.uniq { |row| row['tx_nome_parlamentar'] && row['ide_cadastro'] }

      parliamentarians.each do |parliamentary|
        parliamentary = {
          'tx_nome_parlamentar': parliamentary['tx_nome_parlamentar'],
          'ide_cadastro': parliamentary['ide_cadastro'],
          'sg_uf': parliamentary['sg_uf'],
          'sg_partido': parliamentary['sg_partido'],
          'avatar': parliamentary['avatar'],
          'avatar_congresso': parliamentary['avatar_congresso']
        }

        Parliamentary.find_or_create_by(parliamentary)
      end
    end

    def create_spents(parliamentarians)
      parliamentarians.each do |parliamentary|
        spent = Spent.find_or_initialize_by(parliamentary.except('avatar', 'avatar_congresso'))
        spent['parliamentary_id'] = Parliamentary.find_by(ide_cadastro: parliamentary['ide_cadastro']).id
        spent.save
      end
    end
  end
end
