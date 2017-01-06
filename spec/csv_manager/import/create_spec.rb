require "spec_helper"

describe "CSVManager::Import#create" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  describe "when model and hash_arr are given" do
    it "populates database" do
      @importer.parse(@csv_path + "products.csv")
      hash_arr = @importer.entire[0..2]
      old_count = Product.count

      @importer.create(Product, hash_arr)
      new_count = Product.count
      expect(new_count - old_count).to eq 3
    end
  end

  describe "when model is given but not hash_arr" do
    it "populates database" do
      @importer.parse(@csv_path + "inventories.csv")
      old_count = Product.count

      @importer.create(Product)
      new_count = Product.count
      expect(new_count - old_count).to eq 5
    end
  end
end
