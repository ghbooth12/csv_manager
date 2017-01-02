require "spec_helper"
require "rspec/rails"

describe "CSVManager::Export#download" do
  before do
    @pen = Product.create(name: "pen", category: "office", quantity: 35)
    @crayon = Product.create(name: "crayon", category: "craft", quantity: 20)
    @products_controller = ProductsController.new
    @exporter = CSVManager::Export.new
  end

  it "downloads a csv file with given controller and given objects" do
    objs = Product.all
    # text = @exporter.to_csv(objs)
    @exporter.download(@products_controller, objs)
    # @products_controller.expects(:send_data).with(text).returns(:success)
  end
end
