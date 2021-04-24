class CsvImportController < ApplicationController
  def index
  end

  def csv_import
    if params["csv"].present? && params["csv"].tempfile.path.include?(".csv")
      app_temp_file_path = "/tmp/#{SecureRandom.urlsafe_base64}.csv"
      IO.copy_stream(params["csv"].tempfile.path, app_temp_file_path)

      ImportCsvJob.perform_later(app_temp_file_path)
      flash[:alert] = "Aguarde enquanto importamos os dados..."
    elsif params["csv"].present?  && !params["csv"].tempfile.path.include?(".csv")
      redirect_to csv_import_index_path, alert: "Não é um arquivo CSV válido."
    else
      redirect_to csv_import_index_path, alert: "Você precisa escolher um arquivo CSV."
    end
  end
end
