require "spec_helper"

describe "missing_quote_csv" do
  before do
    @importer = CSVManager::Import.new
    @csv_path = Dir.pwd + "/spec/csvs/"
  end

  it "handles a poorly formatted CSV file" do
    expect { @importer.parse(@csv_path + "missing_quote.csv") }.to raise_error(CSV::MalformedCSVError)
  end
end
