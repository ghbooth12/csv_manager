require "spec_helper"

describe CSVManager::Import do
  describe "#parse" do
    before do
      @importer = CSVManager::Import.new
      @cwd = Dir.pwd
    end

    it "handles a properly formatted CSV file" do
      @importer.parse(@cwd + "/spec/temp.csv", true)
      expect(@importer.entire).to_not eq []
    end

    it "handles a poorly formatted CSV file" do
      @importer.parse(@cwd + "/spec/bad_temp.csv", true)
      expect(@importer.entire).to eq []
    end
  end
end
