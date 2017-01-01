require "spec_helper"

describe "CSVManager::Export#to_csv" do
  let(:product) { Product.new }
  let(:exporter) { CSVManager::Export.new }

  it "test1" do
    expect(product.class).to eq Product
    exporter.to_csv(product)
    
  end
end
