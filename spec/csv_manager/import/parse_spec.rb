require "spec_helper"

describe CSVManager do
  describe "CSVManager::Import#parse" do
    before do
      @importer = CSVManager::Import.new
      @csv_path = Dir.pwd + "/spec/csvs/"
    end

    it "parses given CSV file into cols, rows, entire" do
      @importer.parse(@csv_path + "inventories.csv")
      cols = ["name","category","quantity"]

      rows = [["pen", "stationery", 100],
              ["bowl", "kitchen", 110],
              ["banana", "fruit", 20],
              ["soap", "bath", 30],
              ["peppermint", "tea", 50]]

      entire = [{"name"=>"pen", "category"=>"stationery", "quantity"=>100},
                {"name"=>"bowl", "category"=>"kitchen", "quantity"=>110},
                {"name"=>"banana", "category"=>"fruit", "quantity"=>20},
                {"name"=>"soap", "category"=>"bath", "quantity"=>30},
                {"name"=>"peppermint", "category"=>"tea", "quantity"=>50}]

      expect(@importer.cols).to eq cols
      expect(@importer.rows).to eq rows
      expect(@importer.entire).to eq entire
    end
  end
end
