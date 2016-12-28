require "spec_helper"

describe "CSVManager::Import#get_contents" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "gets the contents of the given column" do
    @importer.parse(@csv_path + "inventories.csv")
    names = ["pen", "bowl", "banana", "soap", "peppermint"]
    types = ["stationery", "kitchen", "fruit", "bath", "tea"]
    quantities = [100, 110, 20, 30, 50]

    expect(@importer.get_contents("name")).to eq names
    expect(@importer.get_contents("type")).to eq types
    expect(@importer.get_contents("quantity")).to eq quantities
  end
end
