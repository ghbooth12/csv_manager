require "spec_helper"

describe "CSVManager::Export#to_csv" do
  before do
    @pen = Product.create(name: "pen", category: "office", quantity: 35)
    @crayon = Product.create(name: "crayon", category: "craft", quantity: 20)
    @exporter = CSVManager::Export.new
  end

  it "generates a csv file with given objects" do
    objs = Product.all
    @exporter.to_csv(objs)
  end
end
