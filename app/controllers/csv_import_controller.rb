class CsvImportController < ApplicationController
  def index
  end

  def csv_import
    if params["csv"].present?
      CsvImporter.import(params)
      redirect_to root_path, notice: "Arquivos importados com sucesso!"
    else
      redirect_to csv_import_index_path, notice: "Você precisa escolher um arquivo CSV!"
    end
  end
end
