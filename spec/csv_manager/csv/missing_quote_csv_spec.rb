require "spec_helper"

describe "missing_quote_csv" do
  before do
    @importer = CSVManager::Import.new
    @file = Dir.pwd + "/spec/csvs/missing_quote_head.csv"
  end

  context "when CSV file is poorly formatted" do
    describe "when CSV's header is malformed" do
      it "assigns error message to @error" do
        @importer.parse(@file)

        expect(@importer.cols).to eq []
        expect(@importer.rows).to eq []
        expect(@importer.entire).to eq []
        expect(@importer.error).not_to eq nil
      end
    end

    describe "when CSV's body is malformed" do
      it "assigns error message to @error" do
        @importer.parse(@file)

        expect(@importer.cols).to eq []
        expect(@importer.rows).to eq []
        expect(@importer.entire).to eq []
        expect(@importer.error).not_to eq nil
      end
    end
  end
end
