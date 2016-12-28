require "spec_helper"

describe "numeric_csv" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "handles a numeric data in CSV" do
    @importer.parse(@csv_path + "numeric.csv")
    expect(@importer.entire[0]["type"].class).to eq String
    expect(@importer.entire[0]["quantity"].class).to eq Fixnum
    expect(@importer.entire[0]["size"].class).to eq Fixnum
    expect(@importer.entire[3]["type"].class).to eq String
    expect(@importer.entire[3]["quantity"].class).to eq Fixnum
    expect(@importer.entire[3]["size"].class).to eq Fixnum
  end
end
