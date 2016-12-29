require "spec_helper"

describe "CSVManager::Import#create" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "" do
    @importer.parse(@csv_path + "inventories.csv")
    @importer.create()

  end
end
