require "spec_helper"

describe "CSVManager::Export#download" do
  before do
    @pen = Product.create(name: "pen", category: "office", quantity: 35)
    @crayon = Product.create(name: "crayon", category: "craft", quantity: 20)
    @products_controller = ProductsController.new
    @products_controller.instance_variable_set(:@_response, ActionDispatch::Response.new)
    @exporter = CSVManager::Export.new
  end

  describe "when controller is nil" do
    it "returns nil without throwing an error" do
      objs = Product.all
      nil_controller = nil

      result = @exporter.download(nil_controller, objs)
      expect(result).to eq nil
    end
  end

  describe "when objs is nil" do
    it "returns nil without throwing an error" do
      objs = nil

      result = @exporter.download(@product_controller, objs)
      expect(result).to eq nil
    end
  end

  describe "when controller && objs are nil" do
    it "returns nil without throwing an error" do
      objs = nil
      nil_controller = nil

      result = @exporter.download(nil_controller, objs)
      expect(result).to eq nil
    end
  end

  describe "when controller and objs are not nil" do
    it "returns a CSV formatted string with given controller and given objects" do
      objs = Product.all
      text = @exporter.to_csv(objs)

      result = @exporter.download(@products_controller, objs)
      expect(result).to eq [text]
    end
  end
end
