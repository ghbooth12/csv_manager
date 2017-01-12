require "spec_helper"

describe "CSVManager::Import#validate" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  describe "when hash_arr is not an array" do
    it "returns false" do
      @importer.parse(@csv_path + "products.csv")

      csv_hash = @importer.entire.first
      expect(@importer.validate(Product, csv_hash)).to eq false
    end
  end

  describe "when columns of CSV file don't match with model's attributes" do
    it "returns false" do
      @importer.parse(@csv_path + "diff_cols.csv")

      csv_hash = @importer.entire
      expect(@importer.validate(Product, csv_hash)).to eq false
    end
  end

  describe "when appropriate model and hash_arr are given" do
    it "returns true" do
      @importer.parse(@csv_path + "products.csv")
      hash_arr = @importer.entire[0..2]

      expect(@importer.validate(Product, hash_arr)).to eq true
    end
  end
end
