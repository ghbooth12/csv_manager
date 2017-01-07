require "spec_helper"

describe "omitted_data_csv" do
  before do
    @importer = CSVManager::Import.new
    @file = Dir.pwd + "/spec/csvs/omitted_data.csv"
  end

  describe "when data is omitted in CSV file" do
    it "does not break and completes parsing" do
      @importer.parse(@file)
      
      expect(@importer.cols).not_to eq []
      expect(@importer.rows).not_to eq []
      expect(@importer.entire).not_to eq []
      expect(@importer.error).to eq nil
    end
  end
end
