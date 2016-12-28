require "spec_helper"

describe "empty_string_csv" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "handles an empty string in CSV file" do
    @importer.parse(@csv_path + "empty_string.csv")
    expect(@importer.entire[1]["name"]).to_not eq ""
    expect(@importer.entire[1]["type"]).to eq ""
    expect(@importer.entire[3]["name"]).to eq ""
    expect(@importer.entire[3]["type"]).to_not eq ""
  end
end
