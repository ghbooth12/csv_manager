require "spec_helper"

describe "CSVManager::Import#parse" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"

    @rows = [["fruit", "apple", "red", 1], ["fruit", "banana", "yellow", 0.5], ["vegetable", "kale", "green", 2], ["vegetable", "spinach", "green", 3]]

    @entire = [{"col1"=>"fruit", "col2"=>"apple", "col3"=>"red", "col4"=>1}, {"col1"=>"fruit", "col2"=>"banana", "col3"=>"yellow", "col4"=>0.5}, {"col1"=>"vegetable", "col2"=>"kale", "col3"=>"green", "col4"=>2}, {"col1"=>"vegetable", "col2"=>"spinach", "col3"=>"green", "col4"=>3}]
  end

  describe "when file is nil" do
    it "returns nil" do
      @importer.parse(nil)

      expect(@importer.cols).to eq []
      expect(@importer.rows).to eq []
      expect(@importer.entire).to eq []
      expect(@importer.error).to eq nil
    end
  end

  context "when header has a different value" do
    describe "when headers is a symbol" do
      it "does not break and completes parsing" do
        file = @csv_path + "custom_headers.csv"
        headers = :wrong

        @importer.parse(file, headers)

        expect(@importer.cols).not_to eq []
        expect(@importer.rows).not_to eq []
        expect(@importer.entire).not_to eq []
        expect(@importer.error).to eq nil
      end
    end

    describe "when headers is a number" do
      it "does not break and completes parsing" do
        file = @csv_path + "custom_headers.csv"
        headers = 5

        @importer.parse(file, headers)

        expect(@importer.cols).not_to eq []
        expect(@importer.rows).not_to eq []
        expect(@importer.entire).not_to eq []
        expect(@importer.error).to eq nil
      end
    end

    describe "when headers is a string" do
      it "parses the given CSV file" do
        file = @csv_path + "custom_headers.csv"
        headers = "col1,col2,col3,col4"

        @importer.parse(file, headers)

        expect(@importer.cols.join(',')).to eq headers
        expect(@importer.rows).to eq @rows
        expect(@importer.entire).to eq @entire
        expect(@importer.error).to eq nil
      end
    end

    describe "when headers is an array" do
      it "parses the given CSV file" do
        file = @csv_path + "custom_headers.csv"
        headers = ["col1", "col2", "col3", "col4"]

        @importer.parse(file, headers)

        expect(@importer.cols).to eq headers
        expect(@importer.rows).to eq @rows
        expect(@importer.entire).to eq @entire
        expect(@importer.error).to eq nil
      end
    end
  end

  describe "when file that includes headers is given" do
    it "parses the given CSV file" do
      file = @csv_path + "inventories.csv"

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

      @importer.parse(file)

      expect(@importer.cols).to eq cols
      expect(@importer.rows).to eq rows
      expect(@importer.entire).to eq entire
      expect(@importer.error).to eq nil
    end
  end
end
