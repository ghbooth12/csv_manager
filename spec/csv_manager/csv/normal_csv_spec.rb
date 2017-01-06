require "spec_helper"

describe "normal_csv" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "handles a properly formatted CSV file" do
    @importer.parse(@csv_path + "inventories.csv")
    expect(@importer.entire).to_not eq []
    expect(@importer.cols.size).to eq 3
    expect(@importer.rows.size).to eq 5
  end
end
