class CsvImportController < ApplicationController
  def index
  end

  def csv_import
    if params["csv"].present? && params["csv"].tempfile.path.include?(".csv")
      CsvImporter.import(params)
      redirect_to root_path, notice: "Arquivos importados com sucesso!"
    else
      redirect_to csv_import_index_path, alert: "Você precisa escolher um arquivo CSV!"
    end
  end
end
