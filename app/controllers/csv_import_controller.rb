class CsvImportController < ApplicationController
  def index
  end

  def csv_import
    CsvImporter.import(params)
    redirect_to root_path, notice: "Arquivos importados com sucesso!"
  end
end
