require "spec_helper"

describe "CSVManager::Import#count" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "counts rows of data in CSV file properly" do
    expect(@importer.count).to eq 0

    @importer.parse(@csv_path + "inventories.csv")
    expect(@importer.count).to eq 5
  end
end
