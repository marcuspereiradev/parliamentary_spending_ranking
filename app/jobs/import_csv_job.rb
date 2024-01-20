# frozen_string_literal: true

# ImportCsvJob
class ImportCsvJob < ApplicationJob
  queue_as :import_csv

  def perform(args)
    CsvImporter.import(args)
  end
end
