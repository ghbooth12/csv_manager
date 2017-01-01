require "spec_helper"

describe "CSVManager::Import#create" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "populates database" do
    @importer.parse(@csv_path + "inventories.csv")
    expect(Product.count).to eq 0
    @importer.create(Product)
    expect(Product.count).to eq 5
  end
end
