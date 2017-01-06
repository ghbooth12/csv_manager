require "spec_helper"

describe "CSVManager::Export#to_csv" do
  before do
    @pen = Product.create(name: "pen", category: "office", quantity: 35)
    @crayon = Product.create(name: "crayon", category: "craft", quantity: 20)
    @exporter = CSVManager::Export.new
  end

  describe "when objs is nil" do
    it "returns nil" do
      expect(@exporter.to_csv(nil)).to eq nil
    end
  end

  describe "when objs is an instance of Product" do
    it "returns nil" do
      expect(@exporter.to_csv(@pen)).to eq nil
    end
  end

  describe "when objs is an array of Product's instance" do
    it "generates a csv formatted string with given object" do
      objs = [@crayon]
      headers = "id,name,category,quantity,created_at,updated_at\n"
      crayon = "crayon,craft,20"

      result = @exporter.to_csv(objs)
      expect(result.include?(headers)).to eq true
      expect(result.include?(crayon)).to eq true
    end
  end

  describe "when objs is an instance of ActiveRecord::Relation" do
    it "generates a csv formatted string with given objects" do
      objs = Product.all
      headers = "id,name,category,quantity,created_at,updated_at\n"
      pen = "pen,office,35"
      crayon = "crayon,craft,20"

      result = @exporter.to_csv(objs)
      expect(result.include?(headers)).to eq true
      expect(result.include?(pen)).to eq true
      expect(result.include?(crayon)).to eq true
    end
  end
end
