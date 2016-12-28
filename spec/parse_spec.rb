require "spec_helper"

describe CSVManager do
  describe "CSVManager::Import#parse" do
    before do
      @importer = CSVManager::Import.new
      @csv_path = Dir.pwd + "/spec/csvs/"
    end

    it "parses given CSV file into cols, rows, entire" do
      @importer.parse(@csv_path + "inventories.csv")
      cols = ["name","type","quantity"]

      rows = [["pen", "stationery", 100],
              ["bowl", "kitchen", 110],
              ["banana", "fruit", 20],
              ["soap", "bath", 30],
              ["peppermint", "tea", 50]]

      entire = [{"name"=>"pen", "type"=>"stationery", "quantity"=>100},
                {"name"=>"bowl", "type"=>"kitchen", "quantity"=>110},
                {"name"=>"banana", "type"=>"fruit", "quantity"=>20},
                {"name"=>"soap", "type"=>"bath", "quantity"=>30},
                {"name"=>"peppermint", "type"=>"tea", "quantity"=>50}]

      expect(@importer.cols).to eq cols
      expect(@importer.rows).to eq rows
      expect(@importer.entire).to eq entire
    end
  end
end
