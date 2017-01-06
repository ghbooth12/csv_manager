require "spec_helper"

describe "CSVManager::Export#validate" do
  before do
    @pen = Product.create(name: "pen", category: "office", quantity: 35)
    @crayon = Product.create(name: "crayon", category: "craft", quantity: 20)
    @exporter = CSVManager::Export.new
  end

  describe "when objs is an array and elements in the objs are not an instance of ActiveRecord::Base" do
    it "returns false" do
      objs = [nil, "a", 2]
      expect(@exporter.validate(objs)).to eq false
    end
  end

  describe "when objs is an array and elements in the objs are an instance of ActiveRecord::Base" do
    it "returns true" do
      objs = [@pen, @crayon]
      expect(@exporter.validate(objs)).to eq true
    end
  end

  describe "when objs is not an instance of ActiveRecord::Relation" do
    it "returns false" do
      expect(@exporter.validate(Product)).to eq false
      expect(@exporter.validate(@pen)).to eq false
    end
  end

  describe "when objs is an instance of ActiveRecord::Relation" do
    it "returns true" do
      expect(@exporter.validate(Product.all)).to eq true
    end
  end

end
