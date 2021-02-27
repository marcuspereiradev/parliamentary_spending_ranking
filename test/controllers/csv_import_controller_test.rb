require "test_helper"

class CsvImportControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get csv_import_index_url
    assert_response :success
  end
end
