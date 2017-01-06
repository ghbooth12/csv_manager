require "spec_helper"

describe "custom_headers_csv" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "handles a custom headers" do
    headers = ["type", "name", "color", "price"]
    @importer.parse(@csv_path + "custom_headers.csv", headers)
    expect(@importer.count).to eq 4
    expect(@importer.cols).to eq headers
  end
end
