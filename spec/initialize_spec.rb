require "spec_helper"

describe "CSVManager::Import#initialize" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "initializes and creates instance variables" do
    expect(@importer.cols).to eq []
    expect(@importer.rows).to eq []
    expect(@importer.entire).to eq []
  end
end
