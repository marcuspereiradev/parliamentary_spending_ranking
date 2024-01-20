# frozen_string_literal: true

# CsvImportController
class CsvImportController < ApplicationController
  def index; end

  def csv_import
    return redirect_to csv_import_index_path, alert: 'Não é um arquivo CSV válido.' unless csv_valid?

    if csv_valid?
      app_temp_file_path = build_csv_file_path

      ImportCsvJob.perform_later(app_temp_file_path)

      redirect_to root_path
      return flash[:alert] = 'Aguarde enquanto importamos os dados...'
    end

    redirect_to csv_import_index_path, alert: 'Você precisa escolher um arquivo CSV.'
  end

  def build_csv_file_path
    app_temp_file_path = "/tmp/#{SecureRandom.urlsafe_base64}.csv"
    IO.copy_stream(params['csv'].tempfile.path, app_temp_file_path)

    app_temp_file_path
  end

  def csv_valid?
    params['csv'].present? && params['csv'].tempfile.path.include?('.csv')
  end
end
